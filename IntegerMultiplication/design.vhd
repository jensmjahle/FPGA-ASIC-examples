library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity multiplier is
  port (
    a : in integer;
    b : in integer;
    dout : out integer
  );
end multiplier;

architecture behav of multiplier is
begin
  dout <= a * b;
end behav;
