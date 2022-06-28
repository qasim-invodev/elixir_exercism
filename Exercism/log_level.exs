#Exercise # 6: Log Level - Atoms and Cond

# You are running a system that consists of a few applications producing many logs.
# You want to write a small program that will aggregate those logs and give them labels according to their severity level.
# All applications in your system use the same log codes, but some of the legacy applications don't support all the codes.

defmodule LogLevel do
  def to_label(level, legacy?) do
    cond do
      level == 0 and legacy? == false -> :trace
      level == 1 -> :debug
      level == 2 -> :info
      level == 3 -> :warning
      level == 4 -> :error
      level == 5 and legacy? == false -> :fatal
      true -> :unknown
    end
  end

  def alert_recipient(level, legacy?) do
    cond do
      to_label(level, legacy?) == :error -> :ops
      to_label(level, legacy?) == :fatal -> :ops
      to_label(level, legacy?) == :unknown ->
                                  cond do
                                    legacy? == false -> :dev2
                                    legacy? == true -> :dev1
                                  end
      true -> false
      end
  end
end
