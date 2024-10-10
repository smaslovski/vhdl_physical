context work.physical_simulation;
use work.types.all;

entity rc is
  generic (
    V_MAX, V_MIN : voltage;
    TAU, STEP : real
  );
  port (
    digital_in : in  logic;
    analog_out : out voltage
  );
end entity;

architecture behav of rc is
begin

  charging: process is

    variable realtime, t : real := 0.0;
    variable u : voltage := 0.0;

  begin

    realtime := real(now / 1 fs) * 1.0e-15;

    if digital_in then
      u := u + (V_MAX - u)*(1.0 - exp(-(realtime - t)/TAU));
    else
      u := u + (V_MIN - u)*(1.0 - exp(-(realtime - t)/TAU));
    end if;

    t := realtime;
    analog_out <= u;

    wait for STEP * 1 sec;

  end process;

end architecture;
