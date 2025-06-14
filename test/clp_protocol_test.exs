defmodule ClpProtocolTest do
  use ExUnit.Case
  doctest ClpProtocol

  test "greets the world" do
    assert ClpProtocol.hello() == :world
  end
end
