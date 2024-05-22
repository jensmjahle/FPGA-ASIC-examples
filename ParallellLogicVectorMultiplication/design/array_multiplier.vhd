library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity array_multiplier is
  generic (
    N : integer := 4 -- Number of 16-bit multiplications
  );
  port (
    a_array : in std_logic_vector(16*N-1 downto 0);
    b_array : in std_logic_vector(16*N-1 downto 0);
    dout_array : out std_logic_vector(32*N-1 downto 0)
  );
end array_multiplier;

architecture behav of array_multiplier is

  component multiplier is
    port (
      a : in std_logic_vector(15 downto 0);
      b : in std_logic_vector(15 downto 0);
      dout : out std_logic_vector(31 downto 0)
    );
  end component;

  type std_logic_vector_array is array (natural range <>) of std_logic_vector(15 downto 0);
  type std_logic_vector_array_32 is array (natural range <>) of std_logic_vector(31 downto 0);

  signal a_signals : std_logic_vector_array(0 to N-1);
  signal b_signals : std_logic_vector_array(0 to N-1);
  signal dout_signals : std_logic_vector_array_32(0 to N-1);

begin
  gen_multipliers: for i in 0 to N-1 generate
  begin
    a_signals(i) <= a_array(16*(i+1)-1 downto 16*i);
    b_signals(i) <= b_array(16*(i+1)-1 downto 16*i);
    dout_array(32*(i+1)-1 downto 32*i) <= dout_signals(i);

    mult_inst: multiplier
      port map (
        a => a_signals(i),
        b => b_signals(i),
        dout => dout_signals(i)
      );
  end generate gen_multipliers;

end behav;
