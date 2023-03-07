-- Copyright (C) 2018  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details.

-- VENDOR "Altera"
-- PROGRAM "Quartus Prime"
-- VERSION "Version 18.0.0 Build 614 04/24/2018 SJ Lite Edition"

-- DATE "02/28/2023 18:36:07"

-- 
-- Device: Altera EP4CGX15BF14C6 Package FBGA169
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY CYCLONEIV;
LIBRARY IEEE;
USE CYCLONEIV.CYCLONEIV_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	hard_block IS
    PORT (
	devoe : IN std_logic;
	devclrn : IN std_logic;
	devpor : IN std_logic
	);
END hard_block;

-- Design Ports Information
-- ~ALTERA_NCEO~	=>  Location: PIN_N5,	 I/O Standard: 2.5 V,	 Current Strength: 16mA
-- ~ALTERA_DATA0~	=>  Location: PIN_A5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ~ALTERA_ASDO~	=>  Location: PIN_B5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ~ALTERA_NCSO~	=>  Location: PIN_C5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ~ALTERA_DCLK~	=>  Location: PIN_A4,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF hard_block IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL \~ALTERA_DATA0~~padout\ : std_logic;
SIGNAL \~ALTERA_ASDO~~padout\ : std_logic;
SIGNAL \~ALTERA_NCSO~~padout\ : std_logic;
SIGNAL \~ALTERA_DATA0~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_ASDO~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_NCSO~~ibuf_o\ : std_logic;

BEGIN

ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
END structure;


LIBRARY ALTERA;
LIBRARY CYCLONEIV;
LIBRARY IEEE;
USE ALTERA.ALTERA_PRIMITIVES_COMPONENTS.ALL;
USE CYCLONEIV.CYCLONEIV_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	lab3 IS
    PORT (
	RA0 : OUT std_logic;
	R1 : IN std_logic;
	R0 : IN std_logic;
	D2 : IN std_logic;
	D1 : IN std_logic;
	CLK : IN std_logic;
	D0 : IN std_logic;
	LOAD_A : IN std_logic;
	EXECUTE : IN std_logic;
	LOAD_B : IN std_logic;
	D3 : IN std_logic;
	F1 : IN std_logic;
	F0 : IN std_logic;
	F2 : IN std_logic;
	RA1 : OUT std_logic;
	RA2 : OUT std_logic;
	RA3 : OUT std_logic;
	RB0 : OUT std_logic;
	RB1 : OUT std_logic;
	RB2 : OUT std_logic;
	RB3 : OUT std_logic;
	S : OUT std_logic;
	C0 : OUT std_logic;
	C1 : OUT std_logic;
	Q : OUT std_logic
	);
END lab3;

-- Design Ports Information
-- RA0	=>  Location: PIN_N13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- RA1	=>  Location: PIN_K9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- RA2	=>  Location: PIN_N8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- RA3	=>  Location: PIN_H12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- RB0	=>  Location: PIN_M13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- RB1	=>  Location: PIN_M9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- RB2	=>  Location: PIN_L13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- RB3	=>  Location: PIN_L9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- S	=>  Location: PIN_L7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- C0	=>  Location: PIN_M6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- C1	=>  Location: PIN_N9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Q	=>  Location: PIN_N6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- D0	=>  Location: PIN_N11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- CLK	=>  Location: PIN_J7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- LOAD_A	=>  Location: PIN_N12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- D1	=>  Location: PIN_N10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- D2	=>  Location: PIN_K8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- R1	=>  Location: PIN_L11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- R0	=>  Location: PIN_L12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- F1	=>  Location: PIN_K10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- F0	=>  Location: PIN_K12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- F2	=>  Location: PIN_K11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- D3	=>  Location: PIN_M11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- LOAD_B	=>  Location: PIN_L5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- EXECUTE	=>  Location: PIN_A9,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF lab3 IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_RA0 : std_logic;
SIGNAL ww_R1 : std_logic;
SIGNAL ww_R0 : std_logic;
SIGNAL ww_D2 : std_logic;
SIGNAL ww_D1 : std_logic;
SIGNAL ww_CLK : std_logic;
SIGNAL ww_D0 : std_logic;
SIGNAL ww_LOAD_A : std_logic;
SIGNAL ww_EXECUTE : std_logic;
SIGNAL ww_LOAD_B : std_logic;
SIGNAL ww_D3 : std_logic;
SIGNAL ww_F1 : std_logic;
SIGNAL ww_F0 : std_logic;
SIGNAL ww_F2 : std_logic;
SIGNAL ww_RA1 : std_logic;
SIGNAL ww_RA2 : std_logic;
SIGNAL ww_RA3 : std_logic;
SIGNAL ww_RB0 : std_logic;
SIGNAL ww_RB1 : std_logic;
SIGNAL ww_RB2 : std_logic;
SIGNAL ww_RB3 : std_logic;
SIGNAL ww_S : std_logic;
SIGNAL ww_C0 : std_logic;
SIGNAL ww_C1 : std_logic;
SIGNAL ww_Q : std_logic;
SIGNAL \CLK~inputclkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \RA0~output_o\ : std_logic;
SIGNAL \RA1~output_o\ : std_logic;
SIGNAL \RA2~output_o\ : std_logic;
SIGNAL \RA3~output_o\ : std_logic;
SIGNAL \RB0~output_o\ : std_logic;
SIGNAL \RB1~output_o\ : std_logic;
SIGNAL \RB2~output_o\ : std_logic;
SIGNAL \RB3~output_o\ : std_logic;
SIGNAL \S~output_o\ : std_logic;
SIGNAL \C0~output_o\ : std_logic;
SIGNAL \C1~output_o\ : std_logic;
SIGNAL \Q~output_o\ : std_logic;
SIGNAL \CLK~input_o\ : std_logic;
SIGNAL \CLK~inputclkctrl_outclk\ : std_logic;
SIGNAL \EXECUTE~input_o\ : std_logic;
SIGNAL \inst39|10~0_combout\ : std_logic;
SIGNAL \inst39|10~q\ : std_logic;
SIGNAL \inst44~combout\ : std_logic;
SIGNAL \inst39|9~q\ : std_logic;
SIGNAL \inst17~combout\ : std_logic;
SIGNAL \inst26|9~q\ : std_logic;
SIGNAL \inst18~combout\ : std_logic;
SIGNAL \inst26|10~q\ : std_logic;
SIGNAL \D0~input_o\ : std_logic;
SIGNAL \D3~input_o\ : std_logic;
SIGNAL \R1~input_o\ : std_logic;
SIGNAL \inst|37~2_combout\ : std_logic;
SIGNAL \R0~input_o\ : std_logic;
SIGNAL \inst|37~3_combout\ : std_logic;
SIGNAL \D1~input_o\ : std_logic;
SIGNAL \D2~input_o\ : std_logic;
SIGNAL \inst1|37~2_combout\ : std_logic;
SIGNAL \inst1|37~0_combout\ : std_logic;
SIGNAL \F2~input_o\ : std_logic;
SIGNAL \F1~input_o\ : std_logic;
SIGNAL \F0~input_o\ : std_logic;
SIGNAL \inst14|22~1_combout\ : std_logic;
SIGNAL \inst14|22~0_combout\ : std_logic;
SIGNAL \inst1|37~1_combout\ : std_logic;
SIGNAL \inst1|37~3_combout\ : std_logic;
SIGNAL \LOAD_B~input_o\ : std_logic;
SIGNAL \inst1|34~1_combout\ : std_logic;
SIGNAL \inst1|41~q\ : std_logic;
SIGNAL \inst1|36~0_combout\ : std_logic;
SIGNAL \inst1|40~q\ : std_logic;
SIGNAL \inst1|35~0_combout\ : std_logic;
SIGNAL \inst1|39~q\ : std_logic;
SIGNAL \inst1|34~0_combout\ : std_logic;
SIGNAL \inst1|38~q\ : std_logic;
SIGNAL \inst|37~0_combout\ : std_logic;
SIGNAL \inst|37~1_combout\ : std_logic;
SIGNAL \inst|37~4_combout\ : std_logic;
SIGNAL \LOAD_A~input_o\ : std_logic;
SIGNAL \inst|34~1_combout\ : std_logic;
SIGNAL \inst|41~q\ : std_logic;
SIGNAL \inst|36~0_combout\ : std_logic;
SIGNAL \inst|40~q\ : std_logic;
SIGNAL \inst|35~0_combout\ : std_logic;
SIGNAL \inst|39~q\ : std_logic;
SIGNAL \inst|34~0_combout\ : std_logic;
SIGNAL \inst|38~q\ : std_logic;

COMPONENT hard_block
    PORT (
	devoe : IN std_logic;
	devclrn : IN std_logic;
	devpor : IN std_logic);
END COMPONENT;

BEGIN

RA0 <= ww_RA0;
ww_R1 <= R1;
ww_R0 <= R0;
ww_D2 <= D2;
ww_D1 <= D1;
ww_CLK <= CLK;
ww_D0 <= D0;
ww_LOAD_A <= LOAD_A;
ww_EXECUTE <= EXECUTE;
ww_LOAD_B <= LOAD_B;
ww_D3 <= D3;
ww_F1 <= F1;
ww_F0 <= F0;
ww_F2 <= F2;
RA1 <= ww_RA1;
RA2 <= ww_RA2;
RA3 <= ww_RA3;
RB0 <= ww_RB0;
RB1 <= ww_RB1;
RB2 <= ww_RB2;
RB3 <= ww_RB3;
S <= ww_S;
C0 <= ww_C0;
C1 <= ww_C1;
Q <= ww_Q;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

\CLK~inputclkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \CLK~input_o\);
auto_generated_inst : hard_block
PORT MAP (
	devoe => ww_devoe,
	devclrn => ww_devclrn,
	devpor => ww_devpor);

-- Location: IOOBUF_X33_Y10_N9
\RA0~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|38~q\,
	devoe => ww_devoe,
	o => \RA0~output_o\);

-- Location: IOOBUF_X22_Y0_N2
\RA1~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|39~q\,
	devoe => ww_devoe,
	o => \RA1~output_o\);

-- Location: IOOBUF_X20_Y0_N9
\RA2~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|40~q\,
	devoe => ww_devoe,
	o => \RA2~output_o\);

-- Location: IOOBUF_X33_Y14_N9
\RA3~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|41~q\,
	devoe => ww_devoe,
	o => \RA3~output_o\);

-- Location: IOOBUF_X33_Y10_N2
\RB0~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst1|38~q\,
	devoe => ww_devoe,
	o => \RB0~output_o\);

-- Location: IOOBUF_X24_Y0_N2
\RB1~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst1|39~q\,
	devoe => ww_devoe,
	o => \RB1~output_o\);

-- Location: IOOBUF_X33_Y12_N9
\RB2~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst1|40~q\,
	devoe => ww_devoe,
	o => \RB2~output_o\);

-- Location: IOOBUF_X24_Y0_N9
\RB3~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst1|41~q\,
	devoe => ww_devoe,
	o => \RB3~output_o\);

-- Location: IOOBUF_X14_Y0_N2
\S~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst26|10~q\,
	devoe => ww_devoe,
	o => \S~output_o\);

-- Location: IOOBUF_X12_Y0_N9
\C0~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst39|9~q\,
	devoe => ww_devoe,
	o => \C0~output_o\);

-- Location: IOOBUF_X20_Y0_N2
\C1~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst39|10~q\,
	devoe => ww_devoe,
	o => \C1~output_o\);

-- Location: IOOBUF_X12_Y0_N2
\Q~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst26|9~q\,
	devoe => ww_devoe,
	o => \Q~output_o\);

-- Location: IOIBUF_X16_Y0_N15
\CLK~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_CLK,
	o => \CLK~input_o\);

-- Location: CLKCTRL_G17
\CLK~inputclkctrl\ : cycloneiv_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \CLK~inputclkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \CLK~inputclkctrl_outclk\);

-- Location: IOIBUF_X16_Y31_N1
\EXECUTE~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_EXECUTE,
	o => \EXECUTE~input_o\);

-- Location: LCCOMB_X25_Y3_N16
\inst39|10~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst39|10~0_combout\ = \inst39|9~q\ $ (\inst39|10~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst39|9~q\,
	datac => \inst39|10~q\,
	combout => \inst39|10~0_combout\);

-- Location: FF_X25_Y3_N17
\inst39|10\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \inst39|10~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst39|10~q\);

-- Location: LCCOMB_X25_Y3_N30
inst44 : cycloneiv_lcell_comb
-- Equation(s):
-- \inst44~combout\ = (\inst26|9~q\ & (((!\inst39|9~q\ & \inst39|10~q\)))) # (!\inst26|9~q\ & ((\EXECUTE~input_o\) # ((!\inst39|9~q\ & \inst39|10~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100111101000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst26|9~q\,
	datab => \EXECUTE~input_o\,
	datac => \inst39|9~q\,
	datad => \inst39|10~q\,
	combout => \inst44~combout\);

-- Location: FF_X25_Y3_N31
\inst39|9\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \inst44~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst39|9~q\);

-- Location: LCCOMB_X25_Y3_N26
inst17 : cycloneiv_lcell_comb
-- Equation(s):
-- \inst17~combout\ = (\inst39|9~q\) # ((\inst39|10~q\) # (\EXECUTE~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111011111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst39|9~q\,
	datab => \inst39|10~q\,
	datac => \EXECUTE~input_o\,
	combout => \inst17~combout\);

-- Location: FF_X25_Y3_N27
\inst26|9\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \inst17~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst26|9~q\);

-- Location: LCCOMB_X25_Y3_N28
inst18 : cycloneiv_lcell_comb
-- Equation(s):
-- \inst18~combout\ = (\inst39|10~q\) # ((\inst39|9~q\) # ((!\inst26|9~q\ & \EXECUTE~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110111111100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst26|9~q\,
	datab => \inst39|10~q\,
	datac => \inst39|9~q\,
	datad => \EXECUTE~input_o\,
	combout => \inst18~combout\);

-- Location: FF_X25_Y3_N29
\inst26|10\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \inst18~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst26|10~q\);

-- Location: IOIBUF_X26_Y0_N1
\D0~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_D0,
	o => \D0~input_o\);

-- Location: IOIBUF_X29_Y0_N8
\D3~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_D3,
	o => \D3~input_o\);

-- Location: IOIBUF_X31_Y0_N1
\R1~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_R1,
	o => \R1~input_o\);

-- Location: LCCOMB_X26_Y3_N10
\inst|37~2\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst|37~2_combout\ = (\inst26|10~q\ & (((!\R1~input_o\ & \inst|38~q\)))) # (!\inst26|10~q\ & (\D3~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011000010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \D3~input_o\,
	datab => \R1~input_o\,
	datac => \inst|38~q\,
	datad => \inst26|10~q\,
	combout => \inst|37~2_combout\);

-- Location: IOIBUF_X33_Y12_N1
\R0~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_R0,
	o => \R0~input_o\);

-- Location: LCCOMB_X26_Y3_N28
\inst|37~3\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst|37~3_combout\ = (\R1~input_o\ & (\R0~input_o\ & \inst26|10~q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \R1~input_o\,
	datac => \R0~input_o\,
	datad => \inst26|10~q\,
	combout => \inst|37~3_combout\);

-- Location: IOIBUF_X26_Y0_N8
\D1~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_D1,
	o => \D1~input_o\);

-- Location: IOIBUF_X22_Y0_N8
\D2~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_D2,
	o => \D2~input_o\);

-- Location: LCCOMB_X26_Y3_N14
\inst1|37~2\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst1|37~2_combout\ = (\inst26|10~q\ & (((\inst1|38~q\ & !\R0~input_o\)))) # (!\inst26|10~q\ & (\D3~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000110010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \D3~input_o\,
	datab => \inst1|38~q\,
	datac => \R0~input_o\,
	datad => \inst26|10~q\,
	combout => \inst1|37~2_combout\);

-- Location: LCCOMB_X26_Y3_N26
\inst1|37~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst1|37~0_combout\ = (!\R1~input_o\ & (\R0~input_o\ & \inst26|10~q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \R1~input_o\,
	datac => \R0~input_o\,
	datad => \inst26|10~q\,
	combout => \inst1|37~0_combout\);

-- Location: IOIBUF_X33_Y11_N1
\F2~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_F2,
	o => \F2~input_o\);

-- Location: IOIBUF_X31_Y0_N8
\F1~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_F1,
	o => \F1~input_o\);

-- Location: IOIBUF_X33_Y11_N8
\F0~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_F0,
	o => \F0~input_o\);

-- Location: LCCOMB_X26_Y3_N22
\inst14|22~1\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst14|22~1_combout\ = (\F1~input_o\ & ((\F0~input_o\) # (\inst1|38~q\ $ (\inst|38~q\)))) # (!\F1~input_o\ & ((\F0~input_o\ & ((\inst1|38~q\) # (\inst|38~q\))) # (!\F0~input_o\ & (\inst1|38~q\ & \inst|38~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101111011101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \F1~input_o\,
	datab => \F0~input_o\,
	datac => \inst1|38~q\,
	datad => \inst|38~q\,
	combout => \inst14|22~1_combout\);

-- Location: LCCOMB_X26_Y3_N20
\inst14|22~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst14|22~0_combout\ = (\F1~input_o\ & (!\F0~input_o\ & (\inst1|38~q\ $ (!\inst|38~q\)))) # (!\F1~input_o\ & ((\F0~input_o\ & (!\inst1|38~q\ & !\inst|38~q\)) # (!\F0~input_o\ & ((!\inst|38~q\) # (!\inst1|38~q\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000100010111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \F1~input_o\,
	datab => \F0~input_o\,
	datac => \inst1|38~q\,
	datad => \inst|38~q\,
	combout => \inst14|22~0_combout\);

-- Location: LCCOMB_X26_Y3_N16
\inst1|37~1\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst1|37~1_combout\ = (\inst1|37~0_combout\ & ((\F2~input_o\ & ((\inst14|22~0_combout\))) # (!\F2~input_o\ & (\inst14|22~1_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010100000100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|37~0_combout\,
	datab => \F2~input_o\,
	datac => \inst14|22~1_combout\,
	datad => \inst14|22~0_combout\,
	combout => \inst1|37~1_combout\);

-- Location: LCCOMB_X26_Y3_N30
\inst1|37~3\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst1|37~3_combout\ = (\inst1|37~2_combout\) # ((\inst1|37~1_combout\) # ((\inst|38~q\ & \inst|37~3_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|38~q\,
	datab => \inst|37~3_combout\,
	datac => \inst1|37~2_combout\,
	datad => \inst1|37~1_combout\,
	combout => \inst1|37~3_combout\);

-- Location: IOIBUF_X14_Y0_N8
\LOAD_B~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_LOAD_B,
	o => \LOAD_B~input_o\);

-- Location: LCCOMB_X25_Y3_N24
\inst1|34~1\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst1|34~1_combout\ = (\LOAD_B~input_o\) # (\inst26|10~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \LOAD_B~input_o\,
	datad => \inst26|10~q\,
	combout => \inst1|34~1_combout\);

-- Location: FF_X26_Y3_N31
\inst1|41\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \inst1|37~3_combout\,
	ena => \inst1|34~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst1|41~q\);

-- Location: LCCOMB_X25_Y3_N22
\inst1|36~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst1|36~0_combout\ = (\inst26|10~q\ & ((\inst1|41~q\))) # (!\inst26|10~q\ & (\D2~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \D2~input_o\,
	datac => \inst1|41~q\,
	datad => \inst26|10~q\,
	combout => \inst1|36~0_combout\);

-- Location: FF_X25_Y3_N23
\inst1|40\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \inst1|36~0_combout\,
	ena => \inst1|34~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst1|40~q\);

-- Location: LCCOMB_X25_Y3_N0
\inst1|35~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst1|35~0_combout\ = (\inst26|10~q\ & ((\inst1|40~q\))) # (!\inst26|10~q\ & (\D1~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \D1~input_o\,
	datac => \inst1|40~q\,
	datad => \inst26|10~q\,
	combout => \inst1|35~0_combout\);

-- Location: FF_X25_Y3_N1
\inst1|39\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \inst1|35~0_combout\,
	ena => \inst1|34~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst1|39~q\);

-- Location: LCCOMB_X26_Y3_N4
\inst1|34~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst1|34~0_combout\ = (\inst26|10~q\ & ((\inst1|39~q\))) # (!\inst26|10~q\ & (\D0~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \D0~input_o\,
	datac => \inst1|39~q\,
	datad => \inst26|10~q\,
	combout => \inst1|34~0_combout\);

-- Location: FF_X26_Y3_N5
\inst1|38\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \inst1|34~0_combout\,
	ena => \inst1|34~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst1|38~q\);

-- Location: LCCOMB_X26_Y3_N2
\inst|37~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst|37~0_combout\ = (\R1~input_o\ & (!\R0~input_o\ & \inst26|10~q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000110000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \R1~input_o\,
	datac => \R0~input_o\,
	datad => \inst26|10~q\,
	combout => \inst|37~0_combout\);

-- Location: LCCOMB_X26_Y3_N0
\inst|37~1\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst|37~1_combout\ = (\inst|37~0_combout\ & ((\F2~input_o\ & ((\inst14|22~0_combout\))) # (!\F2~input_o\ & (\inst14|22~1_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100100001000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \F2~input_o\,
	datab => \inst|37~0_combout\,
	datac => \inst14|22~1_combout\,
	datad => \inst14|22~0_combout\,
	combout => \inst|37~1_combout\);

-- Location: LCCOMB_X26_Y3_N18
\inst|37~4\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst|37~4_combout\ = (\inst|37~2_combout\) # ((\inst|37~1_combout\) # ((\inst|37~3_combout\ & \inst1|38~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|37~2_combout\,
	datab => \inst|37~3_combout\,
	datac => \inst1|38~q\,
	datad => \inst|37~1_combout\,
	combout => \inst|37~4_combout\);

-- Location: IOIBUF_X29_Y0_N1
\LOAD_A~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_LOAD_A,
	o => \LOAD_A~input_o\);

-- Location: LCCOMB_X26_Y3_N8
\inst|34~1\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst|34~1_combout\ = (\LOAD_A~input_o\) # (\inst26|10~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \LOAD_A~input_o\,
	datad => \inst26|10~q\,
	combout => \inst|34~1_combout\);

-- Location: FF_X26_Y3_N19
\inst|41\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \inst|37~4_combout\,
	ena => \inst|34~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|41~q\);

-- Location: LCCOMB_X26_Y3_N12
\inst|36~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst|36~0_combout\ = (\inst26|10~q\ & (\inst|41~q\)) # (!\inst26|10~q\ & ((\D2~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|41~q\,
	datac => \D2~input_o\,
	datad => \inst26|10~q\,
	combout => \inst|36~0_combout\);

-- Location: FF_X26_Y3_N13
\inst|40\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \inst|36~0_combout\,
	ena => \inst|34~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|40~q\);

-- Location: LCCOMB_X26_Y3_N6
\inst|35~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst|35~0_combout\ = (\inst26|10~q\ & (\inst|40~q\)) # (!\inst26|10~q\ & ((\D1~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|40~q\,
	datac => \D1~input_o\,
	datad => \inst26|10~q\,
	combout => \inst|35~0_combout\);

-- Location: FF_X26_Y3_N7
\inst|39\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \inst|35~0_combout\,
	ena => \inst|34~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|39~q\);

-- Location: LCCOMB_X26_Y3_N24
\inst|34~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst|34~0_combout\ = (\inst26|10~q\ & ((\inst|39~q\))) # (!\inst26|10~q\ & (\D0~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst26|10~q\,
	datac => \D0~input_o\,
	datad => \inst|39~q\,
	combout => \inst|34~0_combout\);

-- Location: FF_X26_Y3_N25
\inst|38\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \inst|34~0_combout\,
	ena => \inst|34~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|38~q\);

ww_RA0 <= \RA0~output_o\;

ww_RA1 <= \RA1~output_o\;

ww_RA2 <= \RA2~output_o\;

ww_RA3 <= \RA3~output_o\;

ww_RB0 <= \RB0~output_o\;

ww_RB1 <= \RB1~output_o\;

ww_RB2 <= \RB2~output_o\;

ww_RB3 <= \RB3~output_o\;

ww_S <= \S~output_o\;

ww_C0 <= \C0~output_o\;

ww_C1 <= \C1~output_o\;

ww_Q <= \Q~output_o\;
END structure;


