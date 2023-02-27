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
-- Generated on "02/27/2023 16:22:55"
                                                             
-- Vhdl Test Bench(with test vectors) for design  :          Lab2
-- 
-- Simulation tool : 3rd Party
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY Lab2_vhd_vec_tst IS
END Lab2_vhd_vec_tst;
ARCHITECTURE Lab2_arch OF Lab2_vhd_vec_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL CLOCK : STD_LOGIC;
SIGNAL DIN0 : STD_LOGIC;
SIGNAL DIN1 : STD_LOGIC;
SIGNAL FETCH : STD_LOGIC;
SIGNAL LDSBR : STD_LOGIC;
SIGNAL Q00 : STD_LOGIC;
SIGNAL Q01 : STD_LOGIC;
SIGNAL Q02 : STD_LOGIC;
SIGNAL Q03 : STD_LOGIC;
SIGNAL Q10 : STD_LOGIC;
SIGNAL Q11 : STD_LOGIC;
SIGNAL Q12 : STD_LOGIC;
SIGNAL Q13 : STD_LOGIC;
SIGNAL SAR0 : STD_LOGIC;
SIGNAL SAR1 : STD_LOGIC;
SIGNAL SBR0 : STD_LOGIC;
SIGNAL SBR1 : STD_LOGIC;
SIGNAL STORE : STD_LOGIC;
COMPONENT Lab2
	PORT (
	CLOCK : IN STD_LOGIC;
	DIN0 : IN STD_LOGIC;
	DIN1 : IN STD_LOGIC;
	FETCH : IN STD_LOGIC;
	LDSBR : IN STD_LOGIC;
	Q00 : OUT STD_LOGIC;
	Q01 : OUT STD_LOGIC;
	Q02 : OUT STD_LOGIC;
	Q03 : OUT STD_LOGIC;
	Q10 : OUT STD_LOGIC;
	Q11 : OUT STD_LOGIC;
	Q12 : OUT STD_LOGIC;
	Q13 : OUT STD_LOGIC;
	SAR0 : IN STD_LOGIC;
	SAR1 : IN STD_LOGIC;
	SBR0 : OUT STD_LOGIC;
	SBR1 : OUT STD_LOGIC;
	STORE : IN STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : Lab2
	PORT MAP (
-- list connections between master ports and signals
	CLOCK => CLOCK,
	DIN0 => DIN0,
	DIN1 => DIN1,
	FETCH => FETCH,
	LDSBR => LDSBR,
	Q00 => Q00,
	Q01 => Q01,
	Q02 => Q02,
	Q03 => Q03,
	Q10 => Q10,
	Q11 => Q11,
	Q12 => Q12,
	Q13 => Q13,
	SAR0 => SAR0,
	SAR1 => SAR1,
	SBR0 => SBR0,
	SBR1 => SBR1,
	STORE => STORE
	);

-- CLOCK
t_prcs_CLOCK: PROCESS
BEGIN
	CLOCK <= '1';
	WAIT FOR 5000 ps;
	FOR i IN 1 TO 99
	LOOP
		CLOCK <= '0';
		WAIT FOR 5000 ps;
		CLOCK <= '1';
		WAIT FOR 5000 ps;
	END LOOP;
	CLOCK <= '0';
WAIT;
END PROCESS t_prcs_CLOCK;

-- DIN0
t_prcs_DIN0: PROCESS
BEGIN
	DIN0 <= '0';
	WAIT FOR 80000 ps;
	DIN0 <= '1';
	WAIT FOR 80000 ps;
	DIN0 <= '0';
	WAIT FOR 90000 ps;
	DIN0 <= '1';
	WAIT FOR 40000 ps;
	DIN0 <= '0';
WAIT;
END PROCESS t_prcs_DIN0;

-- DIN1
t_prcs_DIN1: PROCESS
BEGIN
	DIN1 <= '1';
	WAIT FOR 40000 ps;
	DIN1 <= '0';
	WAIT FOR 80000 ps;
	DIN1 <= '1';
	WAIT FOR 40000 ps;
	DIN1 <= '0';
	WAIT FOR 270000 ps;
	DIN1 <= '1';
	WAIT FOR 40000 ps;
	DIN1 <= '0';
WAIT;
END PROCESS t_prcs_DIN1;

-- SAR0
t_prcs_SAR0: PROCESS
BEGIN
	SAR0 <= '0';
	WAIT FOR 190000 ps;
	SAR0 <= '1';
	WAIT FOR 180000 ps;
	SAR0 <= '0';
	WAIT FOR 260000 ps;
	SAR0 <= '1';
	WAIT FOR 100000 ps;
	SAR0 <= '0';
WAIT;
END PROCESS t_prcs_SAR0;

-- SAR1
t_prcs_SAR1: PROCESS
BEGIN
	SAR1 <= '0';
	WAIT FOR 190000 ps;
	SAR1 <= '1';
	WAIT FOR 90000 ps;
	SAR1 <= '0';
	WAIT FOR 180000 ps;
	SAR1 <= '1';
	WAIT FOR 90000 ps;
	SAR1 <= '0';
	WAIT FOR 80000 ps;
	SAR1 <= '1';
	WAIT FOR 50000 ps;
	SAR1 <= '0';
	WAIT FOR 100000 ps;
	SAR1 <= '1';
	WAIT FOR 50000 ps;
	SAR1 <= '0';
WAIT;
END PROCESS t_prcs_SAR1;

-- LDSBR
t_prcs_LDSBR: PROCESS
BEGIN
	LDSBR <= '1';
	WAIT FOR 30000 ps;
	LDSBR <= '0';
	WAIT FOR 10000 ps;
	LDSBR <= '1';
	WAIT FOR 30000 ps;
	LDSBR <= '0';
	WAIT FOR 10000 ps;
	LDSBR <= '1';
	WAIT FOR 30000 ps;
	LDSBR <= '0';
	WAIT FOR 10000 ps;
	LDSBR <= '1';
	WAIT FOR 30000 ps;
	LDSBR <= '0';
	WAIT FOR 100000 ps;
	LDSBR <= '1';
	WAIT FOR 30000 ps;
	LDSBR <= '0';
	WAIT FOR 60000 ps;
	LDSBR <= '1';
	WAIT FOR 30000 ps;
	LDSBR <= '0';
	WAIT FOR 60000 ps;
	LDSBR <= '1';
	WAIT FOR 30000 ps;
	LDSBR <= '0';
WAIT;
END PROCESS t_prcs_LDSBR;

-- FETCH
t_prcs_FETCH: PROCESS
BEGIN
	FETCH <= '0';
	WAIT FOR 640000 ps;
	FETCH <= '1';
	WAIT FOR 40000 ps;
	FETCH <= '0';
	WAIT FOR 10000 ps;
	FETCH <= '1';
	WAIT FOR 40000 ps;
	FETCH <= '0';
	WAIT FOR 10000 ps;
	FETCH <= '1';
	WAIT FOR 40000 ps;
	FETCH <= '0';
	WAIT FOR 10000 ps;
	FETCH <= '1';
	WAIT FOR 40000 ps;
	FETCH <= '0';
WAIT;
END PROCESS t_prcs_FETCH;

-- STORE
t_prcs_STORE: PROCESS
BEGIN
	STORE <= '0';
	WAIT FOR 200000 ps;
	STORE <= '1';
	WAIT FOR 40000 ps;
	STORE <= '0';
	WAIT FOR 50000 ps;
	STORE <= '1';
	WAIT FOR 40000 ps;
	STORE <= '0';
	WAIT FOR 50000 ps;
	STORE <= '1';
	WAIT FOR 40000 ps;
	STORE <= '0';
	WAIT FOR 50000 ps;
	STORE <= '1';
	WAIT FOR 40000 ps;
	STORE <= '0';
WAIT;
END PROCESS t_prcs_STORE;
END Lab2_arch;
