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

-- *****************************************************************************
-- This file contains a Vhdl test bench with test vectors .The test vectors     
-- are exported from a vector file in the Quartus Waveform Editor and apply to  
-- the top level entity of the current Quartus project .The user can use this   
-- testbench to simulate his design using a third-party simulation tool .       
-- *****************************************************************************
-- Generated on "02/28/2023 18:36:06"
                                                             
-- Vhdl Test Bench(with test vectors) for design  :          lab3
-- 
-- Simulation tool : 3rd Party
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY lab3_vhd_vec_tst IS
END lab3_vhd_vec_tst;
ARCHITECTURE lab3_arch OF lab3_vhd_vec_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL C0 : STD_LOGIC;
SIGNAL C1 : STD_LOGIC;
SIGNAL CLK : STD_LOGIC;
SIGNAL D0 : STD_LOGIC;
SIGNAL D1 : STD_LOGIC;
SIGNAL D2 : STD_LOGIC;
SIGNAL D3 : STD_LOGIC;
SIGNAL EXECUTE : STD_LOGIC;
SIGNAL F0 : STD_LOGIC;
SIGNAL F1 : STD_LOGIC;
SIGNAL F2 : STD_LOGIC;
SIGNAL LOAD_A : STD_LOGIC;
SIGNAL LOAD_B : STD_LOGIC;
SIGNAL Q : STD_LOGIC;
SIGNAL R0 : STD_LOGIC;
SIGNAL R1 : STD_LOGIC;
SIGNAL RA0 : STD_LOGIC;
SIGNAL RA1 : STD_LOGIC;
SIGNAL RA2 : STD_LOGIC;
SIGNAL RA3 : STD_LOGIC;
SIGNAL RB0 : STD_LOGIC;
SIGNAL RB1 : STD_LOGIC;
SIGNAL RB2 : STD_LOGIC;
SIGNAL RB3 : STD_LOGIC;
SIGNAL S : STD_LOGIC;
COMPONENT lab3
	PORT (
	C0 : OUT STD_LOGIC;
	C1 : OUT STD_LOGIC;
	CLK : IN STD_LOGIC;
	D0 : IN STD_LOGIC;
	D1 : IN STD_LOGIC;
	D2 : IN STD_LOGIC;
	D3 : IN STD_LOGIC;
	EXECUTE : IN STD_LOGIC;
	F0 : IN STD_LOGIC;
	F1 : IN STD_LOGIC;
	F2 : IN STD_LOGIC;
	LOAD_A : IN STD_LOGIC;
	LOAD_B : IN STD_LOGIC;
	Q : OUT STD_LOGIC;
	R0 : IN STD_LOGIC;
	R1 : IN STD_LOGIC;
	RA0 : OUT STD_LOGIC;
	RA1 : OUT STD_LOGIC;
	RA2 : OUT STD_LOGIC;
	RA3 : OUT STD_LOGIC;
	RB0 : OUT STD_LOGIC;
	RB1 : OUT STD_LOGIC;
	RB2 : OUT STD_LOGIC;
	RB3 : OUT STD_LOGIC;
	S : OUT STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : lab3
	PORT MAP (
-- list connections between master ports and signals
	C0 => C0,
	C1 => C1,
	CLK => CLK,
	D0 => D0,
	D1 => D1,
	D2 => D2,
	D3 => D3,
	EXECUTE => EXECUTE,
	F0 => F0,
	F1 => F1,
	F2 => F2,
	LOAD_A => LOAD_A,
	LOAD_B => LOAD_B,
	Q => Q,
	R0 => R0,
	R1 => R1,
	RA0 => RA0,
	RA1 => RA1,
	RA2 => RA2,
	RA3 => RA3,
	RB0 => RB0,
	RB1 => RB1,
	RB2 => RB2,
	RB3 => RB3,
	S => S
	);

-- CLK
t_prcs_CLK: PROCESS
BEGIN
LOOP
	CLK <= '0';
	WAIT FOR 5000 ps;
	CLK <= '1';
	WAIT FOR 5000 ps;
	IF (NOW >= 3000000 ps) THEN WAIT; END IF;
END LOOP;
END PROCESS t_prcs_CLK;

-- D3
t_prcs_D3: PROCESS
BEGIN
	D3 <= '0';
	WAIT FOR 70000 ps;
	D3 <= '1';
	WAIT FOR 40000 ps;
	D3 <= '0';
	WAIT FOR 140000 ps;
	D3 <= '1';
	WAIT FOR 40000 ps;
	D3 <= '0';
	WAIT FOR 110000 ps;
	D3 <= '1';
	WAIT FOR 40000 ps;
	D3 <= '0';
	WAIT FOR 160000 ps;
	D3 <= '1';
	WAIT FOR 40000 ps;
	D3 <= '0';
	WAIT FOR 160000 ps;
	D3 <= '1';
	WAIT FOR 40000 ps;
	D3 <= '0';
	WAIT FOR 160000 ps;
	D3 <= '1';
	WAIT FOR 40000 ps;
	D3 <= '0';
	WAIT FOR 160000 ps;
	D3 <= '1';
	WAIT FOR 40000 ps;
	D3 <= '0';
	WAIT FOR 160000 ps;
	D3 <= '1';
	WAIT FOR 40000 ps;
	D3 <= '0';
	WAIT FOR 160000 ps;
	D3 <= '1';
	WAIT FOR 40000 ps;
	D3 <= '0';
	WAIT FOR 160000 ps;
	D3 <= '1';
	WAIT FOR 40000 ps;
	D3 <= '0';
	WAIT FOR 160000 ps;
	D3 <= '1';
	WAIT FOR 40000 ps;
	D3 <= '0';
	WAIT FOR 160000 ps;
	D3 <= '1';
	WAIT FOR 40000 ps;
	D3 <= '0';
	WAIT FOR 160000 ps;
	D3 <= '1';
	WAIT FOR 40000 ps;
	D3 <= '0';
	WAIT FOR 160000 ps;
	D3 <= '1';
	WAIT FOR 40000 ps;
	D3 <= '0';
	WAIT FOR 160000 ps;
	D3 <= '1';
	WAIT FOR 40000 ps;
	D3 <= '0';
WAIT;
END PROCESS t_prcs_D3;

-- D2
t_prcs_D2: PROCESS
BEGIN
	D2 <= '0';
	WAIT FOR 70000 ps;
	D2 <= '1';
	WAIT FOR 40000 ps;
	D2 <= '0';
	WAIT FOR 140000 ps;
	D2 <= '1';
	WAIT FOR 40000 ps;
	D2 <= '0';
	WAIT FOR 110000 ps;
	D2 <= '1';
	WAIT FOR 80000 ps;
	D2 <= '0';
	WAIT FOR 120000 ps;
	D2 <= '1';
	WAIT FOR 80000 ps;
	D2 <= '0';
	WAIT FOR 120000 ps;
	D2 <= '1';
	WAIT FOR 80000 ps;
	D2 <= '0';
	WAIT FOR 120000 ps;
	D2 <= '1';
	WAIT FOR 80000 ps;
	D2 <= '0';
	WAIT FOR 160000 ps;
	D2 <= '1';
	WAIT FOR 40000 ps;
	D2 <= '0';
	WAIT FOR 160000 ps;
	D2 <= '1';
	WAIT FOR 40000 ps;
	D2 <= '0';
	WAIT FOR 160000 ps;
	D2 <= '1';
	WAIT FOR 40000 ps;
	D2 <= '0';
	WAIT FOR 160000 ps;
	D2 <= '1';
	WAIT FOR 40000 ps;
	D2 <= '0';
	WAIT FOR 160000 ps;
	D2 <= '1';
	WAIT FOR 40000 ps;
	D2 <= '0';
	WAIT FOR 160000 ps;
	D2 <= '1';
	WAIT FOR 40000 ps;
	D2 <= '0';
	WAIT FOR 160000 ps;
	D2 <= '1';
	WAIT FOR 40000 ps;
	D2 <= '0';
	WAIT FOR 160000 ps;
	D2 <= '1';
	WAIT FOR 40000 ps;
	D2 <= '0';
	WAIT FOR 160000 ps;
	D2 <= '1';
	WAIT FOR 40000 ps;
	D2 <= '0';
WAIT;
END PROCESS t_prcs_D2;

-- D1
t_prcs_D1: PROCESS
BEGIN
	D1 <= '0';
	WAIT FOR 10000 ps;
	D1 <= '1';
	WAIT FOR 40000 ps;
	D1 <= '0';
	WAIT FOR 140000 ps;
	D1 <= '1';
	WAIT FOR 40000 ps;
	D1 <= '0';
	WAIT FOR 170000 ps;
	D1 <= '1';
	WAIT FOR 80000 ps;
	D1 <= '0';
	WAIT FOR 120000 ps;
	D1 <= '1';
	WAIT FOR 80000 ps;
	D1 <= '0';
	WAIT FOR 120000 ps;
	D1 <= '1';
	WAIT FOR 80000 ps;
	D1 <= '0';
	WAIT FOR 120000 ps;
	D1 <= '1';
	WAIT FOR 80000 ps;
	D1 <= '0';
	WAIT FOR 120000 ps;
	D1 <= '1';
	WAIT FOR 80000 ps;
	D1 <= '0';
	WAIT FOR 120000 ps;
	D1 <= '1';
	WAIT FOR 80000 ps;
	D1 <= '0';
	WAIT FOR 120000 ps;
	D1 <= '1';
	WAIT FOR 80000 ps;
	D1 <= '0';
	WAIT FOR 120000 ps;
	D1 <= '1';
	WAIT FOR 80000 ps;
	D1 <= '0';
	WAIT FOR 120000 ps;
	D1 <= '1';
	WAIT FOR 80000 ps;
	D1 <= '0';
	WAIT FOR 120000 ps;
	D1 <= '1';
	WAIT FOR 80000 ps;
	D1 <= '0';
	WAIT FOR 120000 ps;
	D1 <= '1';
	WAIT FOR 80000 ps;
	D1 <= '0';
	WAIT FOR 120000 ps;
	D1 <= '1';
	WAIT FOR 80000 ps;
	D1 <= '0';
	WAIT FOR 120000 ps;
	D1 <= '1';
	WAIT FOR 80000 ps;
	D1 <= '0';
WAIT;
END PROCESS t_prcs_D1;

-- D0
t_prcs_D0: PROCESS
BEGIN
	D0 <= '0';
	WAIT FOR 10000 ps;
	D0 <= '1';
	WAIT FOR 40000 ps;
	D0 <= '0';
	WAIT FOR 140000 ps;
	D0 <= '1';
	WAIT FOR 40000 ps;
	D0 <= '0';
	WAIT FOR 210000 ps;
	D0 <= '1';
	WAIT FOR 40000 ps;
	D0 <= '0';
	WAIT FOR 160000 ps;
	D0 <= '1';
	WAIT FOR 40000 ps;
	D0 <= '0';
	WAIT FOR 160000 ps;
	D0 <= '1';
	WAIT FOR 40000 ps;
	D0 <= '0';
	WAIT FOR 160000 ps;
	D0 <= '1';
	WAIT FOR 40000 ps;
	D0 <= '0';
	WAIT FOR 160000 ps;
	D0 <= '1';
	WAIT FOR 40000 ps;
	D0 <= '0';
	WAIT FOR 160000 ps;
	D0 <= '1';
	WAIT FOR 40000 ps;
	D0 <= '0';
	WAIT FOR 160000 ps;
	D0 <= '1';
	WAIT FOR 40000 ps;
	D0 <= '0';
	WAIT FOR 160000 ps;
	D0 <= '1';
	WAIT FOR 40000 ps;
	D0 <= '0';
	WAIT FOR 160000 ps;
	D0 <= '1';
	WAIT FOR 40000 ps;
	D0 <= '0';
	WAIT FOR 160000 ps;
	D0 <= '1';
	WAIT FOR 40000 ps;
	D0 <= '0';
	WAIT FOR 160000 ps;
	D0 <= '1';
	WAIT FOR 40000 ps;
	D0 <= '0';
	WAIT FOR 160000 ps;
	D0 <= '1';
	WAIT FOR 40000 ps;
	D0 <= '0';
	WAIT FOR 160000 ps;
	D0 <= '1';
	WAIT FOR 40000 ps;
	D0 <= '0';
WAIT;
END PROCESS t_prcs_D0;

-- F2
t_prcs_F2: PROCESS
BEGIN
	F2 <= '0';
	WAIT FOR 1800000 ps;
	F2 <= '1';
	WAIT FOR 799000 ps;
	F2 <= '0';
	WAIT FOR 1000 ps;
	F2 <= '1';
WAIT;
END PROCESS t_prcs_F2;

-- F1
t_prcs_F1: PROCESS
BEGIN
	F1 <= '0';
	WAIT FOR 1400000 ps;
	F1 <= '1';
	WAIT FOR 400000 ps;
	F1 <= '0';
	WAIT FOR 400000 ps;
	F1 <= '1';
	WAIT FOR 399000 ps;
	F1 <= '0';
	WAIT FOR 1000 ps;
	F1 <= '1';
WAIT;
END PROCESS t_prcs_F1;

-- F0
t_prcs_F0: PROCESS
BEGIN
	F0 <= '0';
	WAIT FOR 1200000 ps;
	F0 <= '1';
	WAIT FOR 200000 ps;
	F0 <= '0';
	WAIT FOR 200000 ps;
	F0 <= '1';
	WAIT FOR 200000 ps;
	F0 <= '0';
	WAIT FOR 200000 ps;
	F0 <= '1';
	WAIT FOR 200000 ps;
	F0 <= '0';
	WAIT FOR 200000 ps;
	F0 <= '1';
	WAIT FOR 199000 ps;
	F0 <= '0';
	WAIT FOR 201000 ps;
	F0 <= '1';
WAIT;
END PROCESS t_prcs_F0;

-- R1
t_prcs_R1: PROCESS
BEGIN
	R1 <= '0';
	WAIT FOR 800000 ps;
	R1 <= '1';
WAIT;
END PROCESS t_prcs_R1;

-- R0
t_prcs_R0: PROCESS
BEGIN
	R0 <= '0';
	WAIT FOR 600000 ps;
	R0 <= '1';
	WAIT FOR 200000 ps;
	R0 <= '0';
	WAIT FOR 200000 ps;
	R0 <= '1';
	WAIT FOR 200000 ps;
	R0 <= '0';
WAIT;
END PROCESS t_prcs_R0;

-- EXECUTE
t_prcs_EXECUTE: PROCESS
BEGIN
	EXECUTE <= '0';
	WAIT FOR 500000 ps;
	EXECUTE <= '1';
	WAIT FOR 100000 ps;
	EXECUTE <= '0';
	WAIT FOR 100000 ps;
	EXECUTE <= '1';
	WAIT FOR 100000 ps;
	EXECUTE <= '0';
	WAIT FOR 100000 ps;
	EXECUTE <= '1';
	WAIT FOR 100000 ps;
	EXECUTE <= '0';
	WAIT FOR 100000 ps;
	EXECUTE <= '1';
	WAIT FOR 100000 ps;
	EXECUTE <= '0';
	WAIT FOR 100000 ps;
	EXECUTE <= '1';
	WAIT FOR 100000 ps;
	EXECUTE <= '0';
	WAIT FOR 100000 ps;
	EXECUTE <= '1';
	WAIT FOR 100000 ps;
	EXECUTE <= '0';
	WAIT FOR 100000 ps;
	EXECUTE <= '1';
	WAIT FOR 100000 ps;
	EXECUTE <= '0';
	WAIT FOR 100000 ps;
	EXECUTE <= '1';
	WAIT FOR 100000 ps;
	EXECUTE <= '0';
	WAIT FOR 110000 ps;
	EXECUTE <= '1';
	WAIT FOR 90000 ps;
	EXECUTE <= '0';
	WAIT FOR 100000 ps;
	EXECUTE <= '1';
	WAIT FOR 100000 ps;
	EXECUTE <= '0';
	WAIT FOR 100000 ps;
	EXECUTE <= '1';
	WAIT FOR 99000 ps;
	EXECUTE <= '0';
	WAIT FOR 101000 ps;
	EXECUTE <= '1';
	WAIT FOR 10000 ps;
	EXECUTE <= '0';
	WAIT FOR 190000 ps;
	EXECUTE <= '1';
	WAIT FOR 10000 ps;
	EXECUTE <= '0';
WAIT;
END PROCESS t_prcs_EXECUTE;

-- LOAD_A
t_prcs_LOAD_A: PROCESS
BEGIN
	LOAD_A <= '0';
	WAIT FOR 30000 ps;
	LOAD_A <= '1';
	WAIT FOR 40000 ps;
	LOAD_A <= '0';
	WAIT FOR 20000 ps;
	LOAD_A <= '1';
	WAIT FOR 20000 ps;
	LOAD_A <= '0';
	WAIT FOR 40000 ps;
	LOAD_A <= '1';
	WAIT FOR 20000 ps;
	LOAD_A <= '0';
	WAIT FOR 250000 ps;
	LOAD_A <= '1';
	WAIT FOR 20000 ps;
	LOAD_A <= '0';
	WAIT FOR 180000 ps;
	LOAD_A <= '1';
	WAIT FOR 20000 ps;
	LOAD_A <= '0';
	WAIT FOR 180000 ps;
	LOAD_A <= '1';
	WAIT FOR 20000 ps;
	LOAD_A <= '0';
	WAIT FOR 180000 ps;
	LOAD_A <= '1';
	WAIT FOR 20000 ps;
	LOAD_A <= '0';
	WAIT FOR 180000 ps;
	LOAD_A <= '1';
	WAIT FOR 20000 ps;
	LOAD_A <= '0';
	WAIT FOR 180000 ps;
	LOAD_A <= '1';
	WAIT FOR 20000 ps;
	LOAD_A <= '0';
	WAIT FOR 180000 ps;
	LOAD_A <= '1';
	WAIT FOR 20000 ps;
	LOAD_A <= '0';
	WAIT FOR 180000 ps;
	LOAD_A <= '1';
	WAIT FOR 20000 ps;
	LOAD_A <= '0';
	WAIT FOR 180000 ps;
	LOAD_A <= '1';
	WAIT FOR 20000 ps;
	LOAD_A <= '0';
	WAIT FOR 180000 ps;
	LOAD_A <= '1';
	WAIT FOR 20000 ps;
	LOAD_A <= '0';
	WAIT FOR 180000 ps;
	LOAD_A <= '1';
	WAIT FOR 20000 ps;
	LOAD_A <= '0';
	WAIT FOR 180000 ps;
	LOAD_A <= '1';
	WAIT FOR 20000 ps;
	LOAD_A <= '0';
	WAIT FOR 180000 ps;
	LOAD_A <= '1';
	WAIT FOR 20000 ps;
	LOAD_A <= '0';
WAIT;
END PROCESS t_prcs_LOAD_A;

-- LOAD_B
t_prcs_LOAD_B: PROCESS
BEGIN
	LOAD_B <= '0';
	WAIT FOR 40000 ps;
	LOAD_B <= '1';
	WAIT FOR 30000 ps;
	LOAD_B <= '0';
	WAIT FOR 140000 ps;
	LOAD_B <= '1';
	WAIT FOR 20000 ps;
	LOAD_B <= '0';
	WAIT FOR 40000 ps;
	LOAD_B <= '1';
	WAIT FOR 20000 ps;
	LOAD_B <= '0';
	WAIT FOR 40000 ps;
	LOAD_B <= '1';
	WAIT FOR 20000 ps;
	LOAD_B <= '0';
	WAIT FOR 110000 ps;
	LOAD_B <= '1';
	WAIT FOR 20000 ps;
	LOAD_B <= '0';
	WAIT FOR 180000 ps;
	LOAD_B <= '1';
	WAIT FOR 20000 ps;
	LOAD_B <= '0';
	WAIT FOR 180000 ps;
	LOAD_B <= '1';
	WAIT FOR 20000 ps;
	LOAD_B <= '0';
	WAIT FOR 180000 ps;
	LOAD_B <= '1';
	WAIT FOR 20000 ps;
	LOAD_B <= '0';
	WAIT FOR 180000 ps;
	LOAD_B <= '1';
	WAIT FOR 20000 ps;
	LOAD_B <= '0';
	WAIT FOR 180000 ps;
	LOAD_B <= '1';
	WAIT FOR 20000 ps;
	LOAD_B <= '0';
	WAIT FOR 180000 ps;
	LOAD_B <= '1';
	WAIT FOR 20000 ps;
	LOAD_B <= '0';
	WAIT FOR 180000 ps;
	LOAD_B <= '1';
	WAIT FOR 20000 ps;
	LOAD_B <= '0';
	WAIT FOR 180000 ps;
	LOAD_B <= '1';
	WAIT FOR 20000 ps;
	LOAD_B <= '0';
	WAIT FOR 180000 ps;
	LOAD_B <= '1';
	WAIT FOR 20000 ps;
	LOAD_B <= '0';
	WAIT FOR 180000 ps;
	LOAD_B <= '1';
	WAIT FOR 20000 ps;
	LOAD_B <= '0';
	WAIT FOR 180000 ps;
	LOAD_B <= '1';
	WAIT FOR 20000 ps;
	LOAD_B <= '0';
	WAIT FOR 180000 ps;
	LOAD_B <= '1';
	WAIT FOR 20000 ps;
	LOAD_B <= '0';
WAIT;
END PROCESS t_prcs_LOAD_B;
END lab3_arch;
