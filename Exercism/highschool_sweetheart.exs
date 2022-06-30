# Exercise # 11 - High School Sweetheart - Strings and Maps - String Interpolation, heredocs

defmodule HighSchoolSweetheart do
  def first_letter(name) do
    String.at(String.trim(name), 0)
  end

  def initial(name) do
    first_letter(String.upcase(name)) <> "."
  end

  def initials(full_name) do
    [head | tail] = String.split(full_name," ")
    last = hd(tail)
    initial(head) <> " " <> initial(last)

  end

  def pair(full_name1, full_name2) do
    """
         ******       ******
       **      **   **      **
     **         ** **         **
    **            *            **
    **                         **
    **     #{initials(full_name1)<>"  +  "<> initials(full_name2)}     **
     **                       **
       **                   **
         **               **
           **           **
             **       **
               **   **
                 ***
                  *
    """
  end
end
