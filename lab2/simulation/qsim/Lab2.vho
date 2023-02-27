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

-- DATE "02/27/2023 16:22:58"

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

ENTITY 	Lab2 IS
    PORT (
	SBR1 : OUT std_logic;
	DIN0 : IN std_logic;
	CLOCK : IN std_logic;
	SAR1 : IN std_logic;
	SAR0 : IN std_logic;
	STORE : IN std_logic;
	FETCH : IN std_logic;
	LDSBR : IN std_logic;
	DIN1 : IN std_logic;
	SBR0 : OUT std_logic;
	Q00 : OUT std_logic;
	Q01 : OUT std_logic;
	Q02 : OUT std_logic;
	Q03 : OUT std_logic;
	Q10 : OUT std_logic;
	Q11 : OUT std_logic;
	Q12 : OUT std_logic;
	Q13 : OUT std_logic
	);
END Lab2;

-- Design Ports Information
-- SBR1	=>  Location: PIN_G10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SBR0	=>  Location: PIN_N13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Q00	=>  Location: PIN_K10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Q01	=>  Location: PIN_J13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Q02	=>  Location: PIN_K13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Q03	=>  Location: PIN_M13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Q10	=>  Location: PIN_L12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Q11	=>  Location: PIN_H12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Q12	=>  Location: PIN_H10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Q13	=>  Location: PIN_L11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- DIN1	=>  Location: PIN_F13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- LDSBR	=>  Location: PIN_F12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- FETCH	=>  Location: PIN_K12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SAR1	=>  Location: PIN_M11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SAR0	=>  Location: PIN_L13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- CLOCK	=>  Location: PIN_J7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- DIN0	=>  Location: PIN_K11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- STORE	=>  Location: PIN_N12,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF Lab2 IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_SBR1 : std_logic;
SIGNAL ww_DIN0 : std_logic;
SIGNAL ww_CLOCK : std_logic;
SIGNAL ww_SAR1 : std_logic;
SIGNAL ww_SAR0 : std_logic;
SIGNAL ww_STORE : std_logic;
SIGNAL ww_FETCH : std_logic;
SIGNAL ww_LDSBR : std_logic;
SIGNAL ww_DIN1 : std_logic;
SIGNAL ww_SBR0 : std_logic;
SIGNAL ww_Q00 : std_logic;
SIGNAL ww_Q01 : std_logic;
SIGNAL ww_Q02 : std_logic;
SIGNAL ww_Q03 : std_logic;
SIGNAL ww_Q10 : std_logic;
SIGNAL ww_Q11 : std_logic;
SIGNAL ww_Q12 : std_logic;
SIGNAL ww_Q13 : std_logic;
SIGNAL \CLOCK~inputclkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \SBR1~output_o\ : std_logic;
SIGNAL \SBR0~output_o\ : std_logic;
SIGNAL \Q00~output_o\ : std_logic;
SIGNAL \Q01~output_o\ : std_logic;
SIGNAL \Q02~output_o\ : std_logic;
SIGNAL \Q03~output_o\ : std_logic;
SIGNAL \Q10~output_o\ : std_logic;
SIGNAL \Q11~output_o\ : std_logic;
SIGNAL \Q12~output_o\ : std_logic;
SIGNAL \Q13~output_o\ : std_logic;
SIGNAL \CLOCK~input_o\ : std_logic;
SIGNAL \CLOCK~inputclkctrl_outclk\ : std_logic;
SIGNAL \LDSBR~input_o\ : std_logic;
SIGNAL \SAR1~input_o\ : std_logic;
SIGNAL \SAR0~input_o\ : std_logic;
SIGNAL \STORE~input_o\ : std_logic;
SIGNAL \inst3|15~0_combout\ : std_logic;
SIGNAL \inst3|15~q\ : std_logic;
SIGNAL \inst8~0_combout\ : std_logic;
SIGNAL \inst5|23~0_combout\ : std_logic;
SIGNAL \inst2|41~q\ : std_logic;
SIGNAL \inst2|40~q\ : std_logic;
SIGNAL \inst2|39~feeder_combout\ : std_logic;
SIGNAL \inst2|39~q\ : std_logic;
SIGNAL \inst2|38~q\ : std_logic;
SIGNAL \DIN1~input_o\ : std_logic;
SIGNAL \inst4|10~0_combout\ : std_logic;
SIGNAL \FETCH~input_o\ : std_logic;
SIGNAL \inst14~0_combout\ : std_logic;
SIGNAL \inst4|10~1_combout\ : std_logic;
SIGNAL \inst6|10~q\ : std_logic;
SIGNAL \inst5|22~0_combout\ : std_logic;
SIGNAL \inst|41~q\ : std_logic;
SIGNAL \inst|40~feeder_combout\ : std_logic;
SIGNAL \inst|40~q\ : std_logic;
SIGNAL \inst|39~feeder_combout\ : std_logic;
SIGNAL \inst|39~q\ : std_logic;
SIGNAL \inst|38~feeder_combout\ : std_logic;
SIGNAL \inst|38~q\ : std_logic;
SIGNAL \DIN0~input_o\ : std_logic;
SIGNAL \inst4|9~0_combout\ : std_logic;
SIGNAL \inst4|9~1_combout\ : std_logic;
SIGNAL \inst6|9~q\ : std_logic;
SIGNAL \ALT_INV_CLOCK~inputclkctrl_outclk\ : std_logic;

COMPONENT hard_block
    PORT (
	devoe : IN std_logic;
	devclrn : IN std_logic;
	devpor : IN std_logic);
END COMPONENT;

BEGIN

SBR1 <= ww_SBR1;
ww_DIN0 <= DIN0;
ww_CLOCK <= CLOCK;
ww_SAR1 <= SAR1;
ww_SAR0 <= SAR0;
ww_STORE <= STORE;
ww_FETCH <= FETCH;
ww_LDSBR <= LDSBR;
ww_DIN1 <= DIN1;
SBR0 <= ww_SBR0;
Q00 <= ww_Q00;
Q01 <= ww_Q01;
Q02 <= ww_Q02;
Q03 <= ww_Q03;
Q10 <= ww_Q10;
Q11 <= ww_Q11;
Q12 <= ww_Q12;
Q13 <= ww_Q13;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

\CLOCK~inputclkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \CLOCK~input_o\);
\ALT_INV_CLOCK~inputclkctrl_outclk\ <= NOT \CLOCK~inputclkctrl_outclk\;
auto_generated_inst : hard_block
PORT MAP (
	devoe => ww_devoe,
	devclrn => ww_devclrn,
	devpor => ww_devpor);

-- Location: IOOBUF_X33_Y22_N9
\SBR1~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst6|10~q\,
	devoe => ww_devoe,
	o => \SBR1~output_o\);

-- Location: IOOBUF_X33_Y10_N9
\SBR0~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst6|9~q\,
	devoe => ww_devoe,
	o => \SBR0~output_o\);

-- Location: IOOBUF_X31_Y0_N9
\Q00~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|38~q\,
	devoe => ww_devoe,
	o => \Q00~output_o\);

-- Location: IOOBUF_X33_Y15_N9
\Q01~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|39~q\,
	devoe => ww_devoe,
	o => \Q01~output_o\);

-- Location: IOOBUF_X33_Y15_N2
\Q02~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|40~q\,
	devoe => ww_devoe,
	o => \Q02~output_o\);

-- Location: IOOBUF_X33_Y10_N2
\Q03~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|41~q\,
	devoe => ww_devoe,
	o => \Q03~output_o\);

-- Location: IOOBUF_X33_Y12_N2
\Q10~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst2|38~q\,
	devoe => ww_devoe,
	o => \Q10~output_o\);

-- Location: IOOBUF_X33_Y14_N9
\Q11~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst2|39~q\,
	devoe => ww_devoe,
	o => \Q11~output_o\);

-- Location: IOOBUF_X33_Y14_N2
\Q12~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst2|40~q\,
	devoe => ww_devoe,
	o => \Q12~output_o\);

-- Location: IOOBUF_X31_Y0_N2
\Q13~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst2|41~q\,
	devoe => ww_devoe,
	o => \Q13~output_o\);

-- Location: IOIBUF_X16_Y0_N15
\CLOCK~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_CLOCK,
	o => \CLOCK~input_o\);

-- Location: CLKCTRL_G17
\CLOCK~inputclkctrl\ : cycloneiv_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \CLOCK~inputclkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \CLOCK~inputclkctrl_outclk\);

-- Location: IOIBUF_X33_Y16_N1
\LDSBR~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_LDSBR,
	o => \LDSBR~input_o\);

-- Location: IOIBUF_X29_Y0_N8
\SAR1~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_SAR1,
	o => \SAR1~input_o\);

-- Location: IOIBUF_X33_Y12_N8
\SAR0~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_SAR0,
	o => \SAR0~input_o\);

-- Location: IOIBUF_X29_Y0_N1
\STORE~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_STORE,
	o => \STORE~input_o\);

-- Location: LCCOMB_X32_Y12_N10
\inst3|15~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst3|15~0_combout\ = !\inst3|15~q\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst3|15~q\,
	combout => \inst3|15~0_combout\);

-- Location: FF_X32_Y12_N11
\inst3|15\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ALT_INV_CLOCK~inputclkctrl_outclk\,
	d => \inst3|15~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst3|15~q\);

-- Location: LCCOMB_X32_Y12_N20
\inst8~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst8~0_combout\ = (\STORE~input_o\ & ((\SAR1~input_o\ & (\SAR0~input_o\ & \inst3|15~q\)) # (!\SAR1~input_o\ & (!\SAR0~input_o\ & !\inst3|15~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \SAR1~input_o\,
	datab => \SAR0~input_o\,
	datac => \STORE~input_o\,
	datad => \inst3|15~q\,
	combout => \inst8~0_combout\);

-- Location: LCCOMB_X32_Y12_N14
\inst5|23~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst5|23~0_combout\ = (\inst8~0_combout\ & (\inst6|10~q\)) # (!\inst8~0_combout\ & ((\inst2|38~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst6|10~q\,
	datac => \inst2|38~q\,
	datad => \inst8~0_combout\,
	combout => \inst5|23~0_combout\);

-- Location: FF_X32_Y12_N15
\inst2|41\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \inst5|23~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst2|41~q\);

-- Location: FF_X32_Y12_N17
\inst2|40\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	asdata => \inst2|41~q\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst2|40~q\);

-- Location: LCCOMB_X32_Y12_N30
\inst2|39~feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst2|39~feeder_combout\ = \inst2|40~q\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \inst2|40~q\,
	combout => \inst2|39~feeder_combout\);

-- Location: FF_X32_Y12_N31
\inst2|39\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \inst2|39~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst2|39~q\);

-- Location: FF_X32_Y12_N9
\inst2|38\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	asdata => \inst2|39~q\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst2|38~q\);

-- Location: IOIBUF_X33_Y16_N8
\DIN1~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_DIN1,
	o => \DIN1~input_o\);

-- Location: LCCOMB_X32_Y12_N4
\inst4|10~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst4|10~0_combout\ = (\LDSBR~input_o\ & (\DIN1~input_o\)) # (!\LDSBR~input_o\ & ((\inst6|10~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111010110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \LDSBR~input_o\,
	datac => \DIN1~input_o\,
	datad => \inst6|10~q\,
	combout => \inst4|10~0_combout\);

-- Location: IOIBUF_X33_Y11_N8
\FETCH~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_FETCH,
	o => \FETCH~input_o\);

-- Location: LCCOMB_X32_Y12_N0
\inst14~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst14~0_combout\ = (\FETCH~input_o\ & ((\SAR1~input_o\ & (\SAR0~input_o\ & \inst3|15~q\)) # (!\SAR1~input_o\ & (!\SAR0~input_o\ & !\inst3|15~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \SAR1~input_o\,
	datab => \FETCH~input_o\,
	datac => \SAR0~input_o\,
	datad => \inst3|15~q\,
	combout => \inst14~0_combout\);

-- Location: LCCOMB_X32_Y12_N12
\inst4|10~1\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst4|10~1_combout\ = (\inst14~0_combout\ & (!\LDSBR~input_o\ & (\inst2|38~q\))) # (!\inst14~0_combout\ & (((\inst4|10~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100010011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \LDSBR~input_o\,
	datab => \inst2|38~q\,
	datac => \inst4|10~0_combout\,
	datad => \inst14~0_combout\,
	combout => \inst4|10~1_combout\);

-- Location: FF_X32_Y12_N13
\inst6|10\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \inst4|10~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst6|10~q\);

-- Location: LCCOMB_X32_Y12_N6
\inst5|22~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst5|22~0_combout\ = (\inst8~0_combout\ & (\inst6|9~q\)) # (!\inst8~0_combout\ & ((\inst|38~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst6|9~q\,
	datab => \inst|38~q\,
	datad => \inst8~0_combout\,
	combout => \inst5|22~0_combout\);

-- Location: FF_X32_Y12_N7
\inst|41\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \inst5|22~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|41~q\);

-- Location: LCCOMB_X32_Y12_N28
\inst|40~feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst|40~feeder_combout\ = \inst|41~q\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \inst|41~q\,
	combout => \inst|40~feeder_combout\);

-- Location: FF_X32_Y12_N29
\inst|40\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \inst|40~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|40~q\);

-- Location: LCCOMB_X32_Y12_N18
\inst|39~feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst|39~feeder_combout\ = \inst|40~q\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \inst|40~q\,
	combout => \inst|39~feeder_combout\);

-- Location: FF_X32_Y12_N19
\inst|39\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \inst|39~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|39~q\);

-- Location: LCCOMB_X32_Y12_N24
\inst|38~feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst|38~feeder_combout\ = \inst|39~q\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \inst|39~q\,
	combout => \inst|38~feeder_combout\);

-- Location: FF_X32_Y12_N25
\inst|38\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \inst|38~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|38~q\);

-- Location: IOIBUF_X33_Y11_N1
\DIN0~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_DIN0,
	o => \DIN0~input_o\);

-- Location: LCCOMB_X32_Y12_N26
\inst4|9~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst4|9~0_combout\ = (\LDSBR~input_o\ & (\DIN0~input_o\)) # (!\LDSBR~input_o\ & ((\inst6|9~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \DIN0~input_o\,
	datac => \inst6|9~q\,
	datad => \LDSBR~input_o\,
	combout => \inst4|9~0_combout\);

-- Location: LCCOMB_X32_Y12_N22
\inst4|9~1\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst4|9~1_combout\ = (\inst14~0_combout\ & (!\LDSBR~input_o\ & (\inst|38~q\))) # (!\inst14~0_combout\ & (((\inst4|9~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100010011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \LDSBR~input_o\,
	datab => \inst|38~q\,
	datac => \inst4|9~0_combout\,
	datad => \inst14~0_combout\,
	combout => \inst4|9~1_combout\);

-- Location: FF_X32_Y12_N23
\inst6|9\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \inst4|9~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst6|9~q\);

ww_SBR1 <= \SBR1~output_o\;

ww_SBR0 <= \SBR0~output_o\;

ww_Q00 <= \Q00~output_o\;

ww_Q01 <= \Q01~output_o\;

ww_Q02 <= \Q02~output_o\;

ww_Q03 <= \Q03~output_o\;

ww_Q10 <= \Q10~output_o\;

ww_Q11 <= \Q11~output_o\;

ww_Q12 <= \Q12~output_o\;

ww_Q13 <= \Q13~output_o\;
END structure;


