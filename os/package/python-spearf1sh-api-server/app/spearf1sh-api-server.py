import os
from flask import request, Flask, Response, render_template, jsonify, flash, redirect, url_for
from flask import send_from_directory
from flask import make_response
from werkzeug.utils import secure_filename
import subprocess
import shlex

app = Flask(__name__, template_folder="static")

ROUTE_PREFIX="/api/v1/"
BITSTREAM_FOLDER = '/tmp/'

app.config['UPLOAD_FOLDER'] = BITSTREAM_FOLDER

app.secret_key = os.urandom(32)

app.add_url_rule(
    "/uploads/<name>", endpoint="download_file", build_only=True
)

def bit2bin(filename):
   bif = open("/tmp/bif", "w")
   bif.write("all:\r\n")
   bif.write("{\r\n")
   bif.write("\t" + os.path.basename(filename))
   bif.write("\r\n")
   bif.write("}\r\n")
   bif.close()

   str = (f"bootgen -w -image /tmp/bif -arch zynq -process_bitstream bin")
   subprocess.run(shlex.split(str), cwd="/tmp", check=True)
   bitbin = f"{filename}"+".bin"
   print (bitbin)

   subprocess.run(shlex.split(f"/usr/local/bin/reconfigure_full_bitstream.sh {bitbin}"), check=True, capture_output=True)


@app.route('/')
def hello_world():
   return 'Hello World'


ALLOWED_EXTENSIONS = {'bit'}
def allowed_file(filename):
    return '.' in filename and \
           filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

@app.route('/uploads/<name>')
def download_file(name):
    return send_from_directory(app.config["UPLOAD_FOLDER"], name)

@app.route(ROUTE_PREFIX + 'reconfigure_full_bitstream', methods=['GET', 'POST'])
def upload_file():
    if request.method == 'POST':
        # check if the post request has the file part
        if 'file' not in request.files:
            flash('No file part')
            return redirect(request.url)
        file = request.files['file']
        # If the user does not select a file, the browser submits an
        # empty file without a filename.
        if file.filename == '':
            flash('No selected file')
            return redirect(request.url)
        if file and allowed_file(file.filename):
           try:
              filename = secure_filename(file.filename)
              print("Saving file")
              fn = os.path.join(app.config['UPLOAD_FOLDER'], filename)
              file.save(fn)
              bit2bin(fn)
              return jsonify(status='ok')
           except Exception as e:
              return make_response(jsonify(msg='failed to update bitstream', exception=repr(e)), 400)

    return '''
    <!doctype html>
    <title>Upload new File</title>
    <h1>Upload new File</h1>
    <form method=post enctype=multipart/form-data>
      <input type=file name=file>
      <input type=submit value=Upload>
    </form>
    '''


if __name__ == "__main__":
    app.run(host='0.0.0.0', debug=True)
