module fulladder
  (input  carryin,
   input  summand1,
   input  summand2,
   output carryout,
   output sum);
  wire halfadder_carry;
  wire halfadder_sum;
  wire halfadder_carryintermediate;
  wire n214_o;
  wire n215_o;
  wire n216_o;
  wire n217_o;
  wire n218_o;
  assign carryout = n218_o;
  assign sum = n216_o;
  /* ../fullAdder.vhdl:15:12  */
  assign halfadder_carry = n214_o; // (signal)
  /* ../fullAdder.vhdl:16:12  */
  assign halfadder_sum = n215_o; // (signal)
  /* ../fullAdder.vhdl:17:12  */
  assign halfadder_carryintermediate = n217_o; // (signal)
  /* ../fullAdder.vhdl:19:33  */
  assign n214_o = summand1 & summand2;
  /* ../fullAdder.vhdl:20:31  */
  assign n215_o = summand1 ^ summand2;
  /* ../fullAdder.vhdl:21:26  */
  assign n216_o = halfadder_sum ^ carryin;
  /* ../fullAdder.vhdl:22:50  */
  assign n217_o = halfadder_sum & carryin;
  /* ../fullAdder.vhdl:23:45  */
  assign n218_o = halfadder_carryintermediate | halfadder_carry;
endmodule

module fulladder_4bit
  (input  carryin_4bit,
   input  [3:0] summand1_4bit,
   input  [3:0] summand2_4bit,
   output carryout_4bit,
   output [3:0] sum_4bit);
  wire carry0;
  wire carry1;
  wire carry2;
  wire c0_carryout;
  wire c0_sum;
  wire n195_o;
  wire n196_o;
  wire c1_carryout;
  wire c1_sum;
  wire n199_o;
  wire n200_o;
  wire c2_carryout;
  wire c2_sum;
  wire n203_o;
  wire n204_o;
  wire c3_carryout;
  wire c3_sum;
  wire n207_o;
  wire n208_o;
  wire [3:0] n211_o;
  assign carryout_4bit = c3_carryout;
  assign sum_4bit = n211_o;
  /* ../fullAdder_4bit.vhdl:16:12  */
  assign carry0 = c0_carryout; // (signal)
  /* ../fullAdder_4bit.vhdl:17:12  */
  assign carry1 = c1_carryout; // (signal)
  /* ../fullAdder_4bit.vhdl:18:12  */
  assign carry2 = c2_carryout; // (signal)
  /* ../fullAdder_4bit.vhdl:21:5  */
  fulladder c0 (
    .carryin(carryin_4bit),
    .summand1(n195_o),
    .summand2(n196_o),
    .carryout(c0_carryout),
    .sum(c0_sum));
  /* ../fullAdder_4bit.vhdl:24:38  */
  assign n195_o = summand1_4bit[0];
  /* ../fullAdder_4bit.vhdl:25:38  */
  assign n196_o = summand2_4bit[0];
  /* ../fullAdder_4bit.vhdl:30:5  */
  fulladder c1 (
    .carryin(carry0),
    .summand1(n199_o),
    .summand2(n200_o),
    .carryout(c1_carryout),
    .sum(c1_sum));
  /* ../fullAdder_4bit.vhdl:33:38  */
  assign n199_o = summand1_4bit[1];
  /* ../fullAdder_4bit.vhdl:34:38  */
  assign n200_o = summand2_4bit[1];
  /* ../fullAdder_4bit.vhdl:39:5  */
  fulladder c2 (
    .carryin(carry1),
    .summand1(n203_o),
    .summand2(n204_o),
    .carryout(c2_carryout),
    .sum(c2_sum));
  /* ../fullAdder_4bit.vhdl:42:38  */
  assign n203_o = summand1_4bit[2];
  /* ../fullAdder_4bit.vhdl:43:38  */
  assign n204_o = summand2_4bit[2];
  /* ../fullAdder_4bit.vhdl:48:5  */
  fulladder c3 (
    .carryin(carry2),
    .summand1(n207_o),
    .summand2(n208_o),
    .carryout(c3_carryout),
    .sum(c3_sum));
  /* ../fullAdder_4bit.vhdl:51:38  */
  assign n207_o = summand1_4bit[3];
  /* ../fullAdder_4bit.vhdl:52:38  */
  assign n208_o = summand2_4bit[3];
  /* ../tt_um_ALU_t_rick.vhdl:102:5  */
  assign n211_o = {c3_sum, c2_sum, c1_sum, c0_sum};
endmodule

module tt_um_ALU_t_rick
  (input  clk,
   input  rst_n,
   input  ena,
   input  [7:0] ui_in,
   input  [7:0] uio_in,
   output [7:0] uo_out,
   output [7:0] uio_out,
   output [7:0] uio_oe);
  wire [3:0] porta;
  wire [3:0] portb;
  wire [3:0] portb_ones_complement;
  wire [3:0] porta_ones_complement;
  wire [3:0] fulladder_sum;
  wire [3:0] andoutput;
  wire [3:0] oroutput;
  wire [3:0] xoroutput;
  wire [3:0] sloutputarithmetic;
  wire [3:0] sloutputlogic;
  wire [3:0] sroutputarithmetic;
  wire [3:0] sroutputlogic;
  wire [3:0] rloutput;
  wire [3:0] rroutput;
  wire [3:0] rltcoutput;
  wire [3:0] rrtcoutput;
  wire [3:0] muxoutput;
  wire carryintermediateadd;
  wire carryintermediaterl;
  wire carryintermediaterr;
  wire carryout;
  wire carryout_saved;
  wire zflag;
  wire nflag;
  wire vflag;
  localparam [7:0] n3_o = 8'b00000000;
  wire [2:0] n5_o;
  wire n7_o;
  wire [3:0] n9_o;
  wire [3:0] n10_o;
  wire n20_o;
  wire n21_o;
  wire n22_o;
  wire n23_o;
  wire n24_o;
  wire n25_o;
  wire n26_o;
  wire n27_o;
  wire n28_o;
  wire n29_o;
  wire n30_o;
  wire n31_o;
  wire fulladder4bit_carryout_4bit;
  wire [3:0] fulladder4bit_sum_4bit;
  wire n33_o;
  wire [3:0] n37_o;
  wire [3:0] n40_o;
  wire [3:0] n43_o;
  wire [3:0] n46_o;
  wire n49_o;
  wire [1:0] n50_o;
  wire [2:0] n54_o;
  wire [2:0] n58_o;
  wire n59_o;
  wire [2:0] n62_o;
  wire [2:0] n66_o;
  wire n67_o;
  wire [2:0] n70_o;
  wire n71_o;
  wire [2:0] n74_o;
  wire n75_o;
  wire [2:0] n78_o;
  wire n79_o;
  wire [3:0] n82_o;
  wire n84_o;
  wire n86_o;
  wire n88_o;
  wire n90_o;
  wire n92_o;
  wire n94_o;
  wire n96_o;
  wire n98_o;
  wire n100_o;
  wire n102_o;
  wire n104_o;
  wire n106_o;
  wire n108_o;
  wire [12:0] n109_o;
  reg [3:0] n110_o;
  reg n121_o;
  wire n124_o;
  wire n125_o;
  wire n126_o;
  wire n127_o;
  wire n128_o;
  wire n129_o;
  wire n130_o;
  wire n131_o;
  wire n132_o;
  wire n133_o;
  wire n134_o;
  wire n135_o;
  wire n136_o;
  wire n137_o;
  wire n138_o;
  wire n139_o;
  wire n140_o;
  wire n141_o;
  wire n142_o;
  wire n143_o;
  wire n144_o;
  wire n145_o;
  wire n146_o;
  wire n147_o;
  wire n148_o;
  wire n149_o;
  wire n150_o;
  wire n151_o;
  wire n152_o;
  wire n153_o;
  wire n154_o;
  wire n155_o;
  wire n156_o;
  wire n157_o;
  wire n158_o;
  wire n159_o;
  wire n160_o;
  wire n161_o;
  wire n162_o;
  wire n163_o;
  wire n164_o;
  wire n165_o;
  wire n166_o;
  wire n169_o;
  wire [7:0] n171_o;
  reg [3:0] n179_q;
  reg [3:0] n180_q;
  wire [3:0] n181_o;
  wire [3:0] n182_o;
  wire [3:0] n183_o;
  wire [3:0] n184_o;
  wire [3:0] n185_o;
  wire [3:0] n186_o;
  wire [3:0] n187_o;
  wire [3:0] n188_o;
  wire [3:0] n189_o;
  reg n190_q;
  reg [7:0] n191_q;
  wire [7:0] n192_o;
  assign uo_out = n191_q;
  assign uio_out = n192_o;
  assign uio_oe = n3_o;
  /* ../tt_um_ALU_t_rick.vhdl:22:12  */
  assign porta = n179_q; // (signal)
  /* ../tt_um_ALU_t_rick.vhdl:23:12  */
  assign portb = n180_q; // (signal)
  /* ../tt_um_ALU_t_rick.vhdl:24:12  */
  assign portb_ones_complement = n181_o; // (signal)
  /* ../tt_um_ALU_t_rick.vhdl:25:12  */
  assign porta_ones_complement = n46_o; // (signal)
  /* ../tt_um_ALU_t_rick.vhdl:26:12  */
  assign fulladder_sum = fulladder4bit_sum_4bit; // (signal)
  /* ../tt_um_ALU_t_rick.vhdl:27:12  */
  assign andoutput = n37_o; // (signal)
  /* ../tt_um_ALU_t_rick.vhdl:28:12  */
  assign oroutput = n40_o; // (signal)
  /* ../tt_um_ALU_t_rick.vhdl:29:12  */
  assign xoroutput = n43_o; // (signal)
  /* ../tt_um_ALU_t_rick.vhdl:30:12  */
  assign sloutputarithmetic = n182_o; // (signal)
  /* ../tt_um_ALU_t_rick.vhdl:31:12  */
  assign sloutputlogic = n183_o; // (signal)
  /* ../tt_um_ALU_t_rick.vhdl:32:12  */
  assign sroutputarithmetic = n184_o; // (signal)
  /* ../tt_um_ALU_t_rick.vhdl:33:12  */
  assign sroutputlogic = n185_o; // (signal)
  /* ../tt_um_ALU_t_rick.vhdl:34:12  */
  assign rloutput = n186_o; // (signal)
  /* ../tt_um_ALU_t_rick.vhdl:35:12  */
  assign rroutput = n187_o; // (signal)
  /* ../tt_um_ALU_t_rick.vhdl:36:12  */
  assign rltcoutput = n188_o; // (signal)
  /* ../tt_um_ALU_t_rick.vhdl:37:12  */
  assign rrtcoutput = n189_o; // (signal)
  /* ../tt_um_ALU_t_rick.vhdl:38:12  */
  assign muxoutput = n110_o; // (signal)
  /* ../tt_um_ALU_t_rick.vhdl:39:12  */
  assign carryintermediateadd = fulladder4bit_carryout_4bit; // (signal)
  /* ../tt_um_ALU_t_rick.vhdl:40:12  */
  assign carryintermediaterl = n75_o; // (signal)
  /* ../tt_um_ALU_t_rick.vhdl:41:12  */
  assign carryintermediaterr = n79_o; // (signal)
  /* ../tt_um_ALU_t_rick.vhdl:42:12  */
  assign carryout = n121_o; // (signal)
  /* ../tt_um_ALU_t_rick.vhdl:43:12  */
  assign carryout_saved = n190_q; // (signal)
  /* ../tt_um_ALU_t_rick.vhdl:44:12  */
  assign zflag = n131_o; // (signal)
  /* ../tt_um_ALU_t_rick.vhdl:45:12  */
  assign nflag = n132_o; // (signal)
  /* ../tt_um_ALU_t_rick.vhdl:46:12  */
  assign vflag = n166_o; // (signal)
  /* ../tt_um_ALU_t_rick.vhdl:52:34  */
  assign n5_o = uio_in[7:5];
  /* ../tt_um_ALU_t_rick.vhdl:56:19  */
  assign n7_o = ~rst_n;
  /* ../tt_um_ALU_t_rick.vhdl:60:27  */
  assign n9_o = ui_in[3:0];
  /* ../tt_um_ALU_t_rick.vhdl:61:27  */
  assign n10_o = ui_in[7:4];
  /* ../tt_um_ALU_t_rick.vhdl:67:42  */
  assign n20_o = portb[0];
  /* ../tt_um_ALU_t_rick.vhdl:67:56  */
  assign n21_o = uio_in[0];
  /* ../tt_um_ALU_t_rick.vhdl:67:46  */
  assign n22_o = n20_o ^ n21_o;
  /* ../tt_um_ALU_t_rick.vhdl:68:42  */
  assign n23_o = portb[1];
  /* ../tt_um_ALU_t_rick.vhdl:68:56  */
  assign n24_o = uio_in[0];
  /* ../tt_um_ALU_t_rick.vhdl:68:46  */
  assign n25_o = n23_o ^ n24_o;
  /* ../tt_um_ALU_t_rick.vhdl:69:42  */
  assign n26_o = portb[2];
  /* ../tt_um_ALU_t_rick.vhdl:69:56  */
  assign n27_o = uio_in[0];
  /* ../tt_um_ALU_t_rick.vhdl:69:46  */
  assign n28_o = n26_o ^ n27_o;
  /* ../tt_um_ALU_t_rick.vhdl:70:42  */
  assign n29_o = portb[3];
  /* ../tt_um_ALU_t_rick.vhdl:70:56  */
  assign n30_o = uio_in[0];
  /* ../tt_um_ALU_t_rick.vhdl:70:46  */
  assign n31_o = n29_o ^ n30_o;
  /* ../tt_um_ALU_t_rick.vhdl:73:5  */
  fulladder_4bit fulladder4bit (
    .carryin_4bit(n33_o),
    .summand1_4bit(porta),
    .summand2_4bit(portb_ones_complement),
    .carryout_4bit(fulladder4bit_carryout_4bit),
    .sum_4bit(fulladder4bit_sum_4bit));
  /* ../tt_um_ALU_t_rick.vhdl:77:35  */
  assign n33_o = uio_in[0];
  /* ../tt_um_ALU_t_rick.vhdl:84:28  */
  assign n37_o = porta & portb;
  /* ../tt_um_ALU_t_rick.vhdl:89:27  */
  assign n40_o = porta | portb;
  /* ../tt_um_ALU_t_rick.vhdl:94:28  */
  assign n43_o = porta ^ portb;
  /* ../tt_um_ALU_t_rick.vhdl:99:34  */
  assign n46_o = ~porta;
  /* ../tt_um_ALU_t_rick.vhdl:104:39  */
  assign n49_o = porta[3];
  /* ../tt_um_ALU_t_rick.vhdl:105:48  */
  assign n50_o = porta[1:0];
  /* ../tt_um_ALU_t_rick.vhdl:111:43  */
  assign n54_o = porta[2:0];
  /* ../tt_um_ALU_t_rick.vhdl:118:52  */
  assign n58_o = porta[3:1];
  /* ../tt_um_ALU_t_rick.vhdl:119:43  */
  assign n59_o = porta[3];
  /* ../tt_um_ALU_t_rick.vhdl:125:47  */
  assign n62_o = porta[3:1];
  /* ../tt_um_ALU_t_rick.vhdl:132:38  */
  assign n66_o = porta[2:0];
  /* ../tt_um_ALU_t_rick.vhdl:133:29  */
  assign n67_o = porta[3];
  /* ../tt_um_ALU_t_rick.vhdl:139:38  */
  assign n70_o = porta[3:1];
  /* ../tt_um_ALU_t_rick.vhdl:140:29  */
  assign n71_o = porta[0];
  /* ../tt_um_ALU_t_rick.vhdl:146:40  */
  assign n74_o = porta[2:0];
  /* ../tt_um_ALU_t_rick.vhdl:148:37  */
  assign n75_o = porta[3];
  /* ../tt_um_ALU_t_rick.vhdl:154:40  */
  assign n78_o = porta[3:1];
  /* ../tt_um_ALU_t_rick.vhdl:156:37  */
  assign n79_o = porta[0];
  /* ../tt_um_ALU_t_rick.vhdl:161:20  */
  assign n82_o = uio_in[4:1];
  /* ../tt_um_ALU_t_rick.vhdl:162:13  */
  assign n84_o = n82_o == 4'b0000;
  /* ../tt_um_ALU_t_rick.vhdl:165:13  */
  assign n86_o = n82_o == 4'b0001;
  /* ../tt_um_ALU_t_rick.vhdl:168:13  */
  assign n88_o = n82_o == 4'b0010;
  /* ../tt_um_ALU_t_rick.vhdl:171:13  */
  assign n90_o = n82_o == 4'b0011;
  /* ../tt_um_ALU_t_rick.vhdl:174:13  */
  assign n92_o = n82_o == 4'b0100;
  /* ../tt_um_ALU_t_rick.vhdl:177:13  */
  assign n94_o = n82_o == 4'b0101;
  /* ../tt_um_ALU_t_rick.vhdl:180:13  */
  assign n96_o = n82_o == 4'b0110;
  /* ../tt_um_ALU_t_rick.vhdl:183:13  */
  assign n98_o = n82_o == 4'b0111;
  /* ../tt_um_ALU_t_rick.vhdl:186:13  */
  assign n100_o = n82_o == 4'b1000;
  /* ../tt_um_ALU_t_rick.vhdl:189:13  */
  assign n102_o = n82_o == 4'b1001;
  /* ../tt_um_ALU_t_rick.vhdl:192:13  */
  assign n104_o = n82_o == 4'b1010;
  /* ../tt_um_ALU_t_rick.vhdl:195:13  */
  assign n106_o = n82_o == 4'b1011;
  /* ../tt_um_ALU_t_rick.vhdl:198:13  */
  assign n108_o = n82_o == 4'b1100;
  assign n109_o = {n108_o, n106_o, n104_o, n102_o, n100_o, n98_o, n96_o, n94_o, n92_o, n90_o, n88_o, n86_o, n84_o};
  /* ../tt_um_ALU_t_rick.vhdl:161:9  */
  always @*
    case (n109_o)
      13'b1000000000000: n110_o = rrtcoutput;
      13'b0100000000000: n110_o = rltcoutput;
      13'b0010000000000: n110_o = rroutput;
      13'b0001000000000: n110_o = rloutput;
      13'b0000100000000: n110_o = sroutputlogic;
      13'b0000010000000: n110_o = sroutputarithmetic;
      13'b0000001000000: n110_o = sloutputlogic;
      13'b0000000100000: n110_o = sloutputarithmetic;
      13'b0000000010000: n110_o = porta_ones_complement;
      13'b0000000001000: n110_o = xoroutput;
      13'b0000000000100: n110_o = oroutput;
      13'b0000000000010: n110_o = andoutput;
      13'b0000000000001: n110_o = fulladder_sum;
      default: n110_o = fulladder_sum;
    endcase
  /* ../tt_um_ALU_t_rick.vhdl:161:9  */
  always @*
    case (n109_o)
      13'b1000000000000: n121_o = carryintermediaterr;
      13'b0100000000000: n121_o = carryintermediaterl;
      13'b0010000000000: n121_o = 1'b0;
      13'b0001000000000: n121_o = 1'b0;
      13'b0000100000000: n121_o = 1'b0;
      13'b0000010000000: n121_o = 1'b0;
      13'b0000001000000: n121_o = 1'b0;
      13'b0000000100000: n121_o = 1'b0;
      13'b0000000010000: n121_o = 1'b0;
      13'b0000000001000: n121_o = 1'b0;
      13'b0000000000100: n121_o = 1'b0;
      13'b0000000000010: n121_o = 1'b0;
      13'b0000000000001: n121_o = carryintermediateadd;
      default: n121_o = carryintermediateadd;
    endcase
  /* ../tt_um_ALU_t_rick.vhdl:209:36  */
  assign n124_o = fulladder_sum[3];
  /* ../tt_um_ALU_t_rick.vhdl:209:56  */
  assign n125_o = fulladder_sum[2];
  /* ../tt_um_ALU_t_rick.vhdl:209:40  */
  assign n126_o = n124_o | n125_o;
  /* ../tt_um_ALU_t_rick.vhdl:209:76  */
  assign n127_o = fulladder_sum[1];
  /* ../tt_um_ALU_t_rick.vhdl:209:60  */
  assign n128_o = n126_o | n127_o;
  /* ../tt_um_ALU_t_rick.vhdl:209:96  */
  assign n129_o = fulladder_sum[0];
  /* ../tt_um_ALU_t_rick.vhdl:209:80  */
  assign n130_o = n128_o | n129_o;
  /* ../tt_um_ALU_t_rick.vhdl:209:18  */
  assign n131_o = ~n130_o;
  /* ../tt_um_ALU_t_rick.vhdl:210:31  */
  assign n132_o = fulladder_sum[3];
  /* ../tt_um_ALU_t_rick.vhdl:211:30  */
  assign n133_o = porta[3];
  /* ../tt_um_ALU_t_rick.vhdl:211:21  */
  assign n134_o = ~n133_o;
  /* ../tt_um_ALU_t_rick.vhdl:211:47  */
  assign n135_o = portb[3];
  /* ../tt_um_ALU_t_rick.vhdl:211:38  */
  assign n136_o = ~n135_o;
  /* ../tt_um_ALU_t_rick.vhdl:211:34  */
  assign n137_o = n134_o & n136_o;
  /* ../tt_um_ALU_t_rick.vhdl:211:68  */
  assign n138_o = fulladder_sum[3];
  /* ../tt_um_ALU_t_rick.vhdl:211:51  */
  assign n139_o = n137_o & n138_o;
  /* ../tt_um_ALU_t_rick.vhdl:211:82  */
  assign n140_o = porta[3];
  /* ../tt_um_ALU_t_rick.vhdl:211:95  */
  assign n141_o = portb[3];
  /* ../tt_um_ALU_t_rick.vhdl:211:86  */
  assign n142_o = n140_o & n141_o;
  /* ../tt_um_ALU_t_rick.vhdl:211:120  */
  assign n143_o = fulladder_sum[3];
  /* ../tt_um_ALU_t_rick.vhdl:211:103  */
  assign n144_o = ~n143_o;
  /* ../tt_um_ALU_t_rick.vhdl:211:99  */
  assign n145_o = n142_o & n144_o;
  /* ../tt_um_ALU_t_rick.vhdl:211:73  */
  assign n146_o = n139_o | n145_o;
  /* ../tt_um_ALU_t_rick.vhdl:211:140  */
  assign n147_o = uio_in[0];
  /* ../tt_um_ALU_t_rick.vhdl:211:130  */
  assign n148_o = ~n147_o;
  /* ../tt_um_ALU_t_rick.vhdl:211:126  */
  assign n149_o = n146_o & n148_o;
  /* ../tt_um_ALU_t_rick.vhdl:211:160  */
  assign n150_o = porta[3];
  /* ../tt_um_ALU_t_rick.vhdl:211:151  */
  assign n151_o = ~n150_o;
  /* ../tt_um_ALU_t_rick.vhdl:211:173  */
  assign n152_o = portb[3];
  /* ../tt_um_ALU_t_rick.vhdl:211:164  */
  assign n153_o = n151_o & n152_o;
  /* ../tt_um_ALU_t_rick.vhdl:211:194  */
  assign n154_o = fulladder_sum[3];
  /* ../tt_um_ALU_t_rick.vhdl:211:177  */
  assign n155_o = n153_o & n154_o;
  /* ../tt_um_ALU_t_rick.vhdl:211:208  */
  assign n156_o = porta[3];
  /* ../tt_um_ALU_t_rick.vhdl:211:225  */
  assign n157_o = portb[3];
  /* ../tt_um_ALU_t_rick.vhdl:211:216  */
  assign n158_o = ~n157_o;
  /* ../tt_um_ALU_t_rick.vhdl:211:212  */
  assign n159_o = n156_o & n158_o;
  /* ../tt_um_ALU_t_rick.vhdl:211:250  */
  assign n160_o = fulladder_sum[3];
  /* ../tt_um_ALU_t_rick.vhdl:211:233  */
  assign n161_o = ~n160_o;
  /* ../tt_um_ALU_t_rick.vhdl:211:229  */
  assign n162_o = n159_o & n161_o;
  /* ../tt_um_ALU_t_rick.vhdl:211:199  */
  assign n163_o = n155_o | n162_o;
  /* ../tt_um_ALU_t_rick.vhdl:211:266  */
  assign n164_o = uio_in[0];
  /* ../tt_um_ALU_t_rick.vhdl:211:256  */
  assign n165_o = n163_o & n164_o;
  /* ../tt_um_ALU_t_rick.vhdl:211:145  */
  assign n166_o = n149_o | n165_o;
  /* ../tt_um_ALU_t_rick.vhdl:217:19  */
  assign n169_o = ~rst_n;
  assign n171_o = {vflag, nflag, zflag, carryout, muxoutput};
  /* ../tt_um_ALU_t_rick.vhdl:59:9  */
  always @(posedge clk or posedge n7_o)
    if (n7_o)
      n179_q <= 4'b0000;
    else
      n179_q <= n9_o;
  /* ../tt_um_ALU_t_rick.vhdl:59:9  */
  always @(posedge clk or posedge n7_o)
    if (n7_o)
      n180_q <= 4'b0000;
    else
      n180_q <= n10_o;
  /* ../tt_um_ALU_t_rick.vhdl:56:9  */
  assign n181_o = {n31_o, n28_o, n25_o, n22_o};
  /* ../tt_um_ALU_t_rick.vhdl:56:9  */
  assign n182_o = {n49_o, n50_o, 1'b0};
  assign n183_o = {n54_o, 1'b0};
  assign n184_o = {n59_o, n58_o};
  assign n185_o = {1'b0, n62_o};
  assign n186_o = {n66_o, n67_o};
  assign n187_o = {n71_o, n70_o};
  assign n188_o = {n74_o, carryout_saved};
  assign n189_o = {carryout_saved, n78_o};
  /* ../tt_um_ALU_t_rick.vhdl:220:9  */
  always @(posedge clk or posedge n169_o)
    if (n169_o)
      n190_q <= 1'b0;
    else
      n190_q <= carryout;
  /* ../tt_um_ALU_t_rick.vhdl:220:9  */
  always @(posedge clk or posedge n169_o)
    if (n169_o)
      n191_q <= 8'b00000000;
    else
      n191_q <= n171_o;
  /* ../tt_um_ALU_t_rick.vhdl:217:9  */
  assign n192_o = {ena, 4'b0000, n5_o};
endmodule

