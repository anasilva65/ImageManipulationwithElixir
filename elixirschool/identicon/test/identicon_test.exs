defmodule IdenticonTest do
  use ExUnit.Case
  doctest Identicon

  test "teste do metodo principal, antes de dividir a lista em sublistas" do
    hash = Identicon.main("banana")
    assert hash != [114, 179, 2, 191, 41, 122, 34, 138, 117, 115, 1, 35, 239, 239, 124]
  end
end
