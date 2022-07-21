defmodule Newsletter do
  def read_emails(path) do
    String.split(File.read!(path),"\n", trim: true)
  end

  def open_log(path) do
    File.open!(path,[:write])
  end

  def log_sent_email(pid, email) do
    IO.puts(pid, email)
  end

  def close_log(pid) do
    File.close(pid)
  end

  def send_newsletter(emails_path, log_path, send_fun) do
    pid = open_log(log_path)

    emails_path
    |> read_emails()
    |> Enum.each(fn email ->
        if send_fun.(email) == :ok do
         log_sent_email(pid, email)
        end
      end)
    close_log(pid)
  end
end
