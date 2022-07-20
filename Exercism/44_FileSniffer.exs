defmodule FileSniffer do
  def type_from_extension(extension) do
    case extension do
      "exe" -> "application/octet-stream"
      "bmp" -> "image/bmp"
      "png" -> "image/png"
      "jpg" -> "image/jpg"
      "gif" -> "image/gif"
    end
  end

  def type_from_binary(file_binary) do
    cond do
      match?(<<0x7F, 0x45, 0x4C, 0x46, _::binary>>,file_binary) -> "application/octet-stream"
      match?(<<0x42, 0x4D, _::binary>>,file_binary) -> "image/bmp"
      match?(<<0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, _::binary>>,file_binary) -> "image/png"
      match?(<<0xFF, 0xD8, 0xFF, _::binary>>,file_binary) -> "image/jpg"
      match?(<<0x47, 0x49, 0x46, _::binary>>,file_binary) -> "image/gif"
    end
  end

  def verify(file_binary, extension) do
    if type_from_binary(file_binary) == type_from_extension(extension) do
      {:ok, type_from_extension(extension)}
    else
      {:error, "Warning, file format and file extension do not match."}
    end
  end
end
