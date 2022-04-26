`timescale 1ns / 1ps

module iic_gpio_tie(
  (* X_INTERFACE_INFO = "xilinx.com:interface:iic:1.0 IIC_S SCL_I" *)
  output s_iic_scl_i, // IIC Serial Clock Input from 3-state buffer (required)
  (* X_INTERFACE_INFO = "xilinx.com:interface:iic:1.0 IIC_S SCL_O" *)
  input s_iic_scl_o, // IIC Serial Clock Output to 3-state buffer (required)
  (* X_INTERFACE_INFO = "xilinx.com:interface:iic:1.0 IIC_S SCL_T" *)
  input s_iic_scl_t, // IIC Serial Clock Output Enable to 3-state buffer (required)
  (* X_INTERFACE_INFO = "xilinx.com:interface:iic:1.0 IIC_S SDA_I" *)
  output s_iic_sda_i, // IIC Serial Data Input from 3-state buffer (required)
  (* X_INTERFACE_INFO = "xilinx.com:interface:iic:1.0 IIC_S SDA_O" *)
  input s_iic_sda_o, // IIC Serial Data Output to 3-state buffer (required)
  (* X_INTERFACE_INFO = "xilinx.com:interface:iic:1.0 IIC_S SDA_T" *)
  input s_iic_sda_t, // IIC Serial Data Output Enable to 3-state buffer (required)


  (* X_INTERFACE_INFO = "xilinx.com:interface:gpio:1.0 GPIO_SCL TRI_T" *)
  input [0:0] s_gpio_scl_t, // Tristate output enable signal (optional)
  (* X_INTERFACE_INFO = "xilinx.com:interface:gpio:1.0 GPIO_SCL TRI_O" *)
  input [0:0] s_gpio_scl_o, // Tristate output signal (optional)
  (* X_INTERFACE_INFO = "xilinx.com:interface:gpio:1.0 GPIO_SCL TRI_I" *)
  output [0:0] s_gpio_scl_i, // Tristate input signal (optional)
  
  (* X_INTERFACE_INFO = "xilinx.com:interface:gpio:1.0 GPIO_SDA TRI_T" *)
  input [0:0] s_gpio_sda_t, // Tristate output enable signal (optional)
  (* X_INTERFACE_INFO = "xilinx.com:interface:gpio:1.0 GPIO_SDA TRI_O" *)
  input [0:0] s_gpio_sda_o, // Tristate output signal (optional)
  (* X_INTERFACE_INFO = "xilinx.com:interface:gpio:1.0 GPIO_SDA TRI_I" *)
  output [0:0] s_gpio_sda_i, // Tristate input signal (optional)
  
  output scl_o,
  inout sda_io
);

  wire sda_i;
  wire sda_o;
  wire sda_t;

  assign s_iic_scl_i = s_gpio_scl_o;
  assign scl_o = s_gpio_scl_o;
  
  assign s_iic_sda_i = sda_i;
  assign s_gpio_sda_i = sda_i;
  
  assign sda_o = (s_gpio_sda_t & !s_iic_sda_t) ? s_iic_sda_o : s_gpio_sda_o;
  assign sda_t = (s_gpio_sda_t & s_iic_sda_t);
    
  IOBUF sda_iobuf (
    .I(sda_o),
    .IO(sda_io),
    .O(sda_i),
    .T(sda_t)
  );

endmodule
