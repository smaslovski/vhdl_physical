context work.physical_simulation;
use work.types.all;
use std.textio.all;
use std.env.all;

entity tb is end entity;

architecture simul of tb is

  constant tau : real := 100.0e-9; -- RC time constant

  signal rc_out  : voltage;
  signal gen_out : logic;

begin

  rc_inst: entity work.rc(behav)
    generic map (
      V_MAX => 4.9,
      V_MIN => 0.1,
      TAU   => tau,
      STEP  => 0.01 * tau
    )
    port map (
      digital_in => gen_out,
      analog_out => rc_out
    );

  schmitt_inv_inst: entity work.schmitt_inv(behav)
    generic map (
      THRESHOLD_L => 2.0,
      THRESHOLD_H => 3.0
    )
    port map (
      trig_in  => rc_out,
      trig_out => gen_out
    );

  log: postponed process is
    variable l: line;
  begin
    swrite(l, "time: "); write(l, now);
    swrite(l, ", rc_out: "); write(l, rc_out);
    swrite(l, ", gen_out: "); write(l, gen_out);
    writeline(output, l);
    wait for 0.1 * tau * 1 sec;
  end process;

  fin: process is
  begin
    wait for 100.0 * tau * 1 sec; finish;
  end process;

end architecture;
