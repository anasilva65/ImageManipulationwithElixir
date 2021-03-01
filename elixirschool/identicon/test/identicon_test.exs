defmodule IdenticonTest do
  use ExUnit.Case
  doctest Identicon

  test "metodo principal, que vai retornar a imagem final" do
    hash = Identicon.main("banana")
    assert hash != [114, 179, 2, 191, 41, 122, 34, 138, 117, 115, 1, 35, 239, 239, 124]
  end

  test "metodo que converte uma string em um mapa" do
    hash = Identicon.hash_input("banana")
    assert hash == %Identicon.Image{
      color: nil,
      grid: nil,
      hex: [114, 179, 2, 191, 41, 122, 34, 138, 117, 115, 1, 35, 239, 239, 124, 65],
      pixel_map: nil
    }
  end

  test "metodo que adiciona valor na propriedade color" do
    image = Identicon.hash_input("banana")
    hash = Identicon.pick_color(image)
    assert hash == %Identicon.Image{
      color: {114, 179, 2},
      grid: nil,
      hex: [114, 179, 2, 191, 41, 122, 34, 138, 117, 115, 1, 35, 239, 239, 124, 65],
      pixel_map: nil
    }
  end

  test "metodo que constroi a grade da imagem" do
    image = Identicon.hash_input("banana")
    hash = Identicon.pick_color(image)
    grid = Identicon.build_grid(hash)
    assert grid == %Identicon.Image{
      color: {114, 179, 2},
      grid: [
        {114, 0},
        {179, 1},
        {2, 2},
        {179, 3},
        {114, 4},
        {191, 5},
        {41, 6},
        {122, 7},
        {41, 8},
        {191, 9},
        {34, 10},
        {138, 11},
        {117, 12},
        {138, 13},
        {34, 14},
        {115, 15},
        {1, 16},
        {35, 17},
        {1, 18},
        {115, 19},
        {239, 20},
        {239, 21},
        {124, 22},
        {239, 23},
        {239, 24}
      ],
      hex: [114, 179, 2, 191, 41, 122, 34, 138, 117, 115, 1, 35, 239, 239, 124, 65],
      pixel_map: nil
    }
  end

  test "metodo que espelha o primeiro e segundo elemento da lista" do
    %{hex: hex} = Identicon.hash_input("banana")
    mirror = Identicon.mirror_row(hex)
    assert mirror == [114, 179, 2, 191, 41, 122, 34, 138, 117, 115, 1, 35, 239, 239, 124, 65, 179, 114]
  end

  test "metodo que filtra os numeros pares" do
    hex = Identicon.hash_input("banana")
    map = Identicon.pick_color(hex)
    hash = Identicon.build_grid(map)
    filter = Identicon.filter_odd_squares(hash)
    assert filter == %Identicon.Image{
      color: {114, 179, 2},
      grid: [
        {114, 0},
        {2, 2},
        {114, 4},
        {122, 7},
        {34, 10},
        {138, 11},
        {138, 13},
        {34, 14},
        {124, 22}
      ],
      hex: [114, 179, 2, 191, 41, 122, 34, 138, 117, 115, 1, 35, 239, 239, 124, 65],
      pixel_map: nil
    }
  end

  test "metodo que calcula as dimensoes do quadrado" do
    hex = Identicon.hash_input("banana")
    map = Identicon.pick_color(hex)
    hash = Identicon.build_grid(map)
    filter = Identicon.filter_odd_squares(hash)
    build = Identicon.build_pixel_map(filter)
    assert build == %Identicon.Image{
      color: {114, 179, 2},
      grid: [
        {114, 0},
        {2, 2},
        {114, 4},
        {122, 7},
        {34, 10},
        {138, 11},
        {138, 13},
        {34, 14},
        {124, 22}
      ],
      hex: [114, 179, 2, 191, 41, 122, 34, 138, 117, 115, 1, 35, 239, 239, 124, 65],
      pixel_map: [
        {{0, 0}, {50, 50}},
        {{100, 0}, {150, 50}},
        {{200, 0}, {250, 50}},
        {{100, 50}, {150, 100}},
        {{0, 100}, {50, 150}},
        {{50, 100}, {100, 150}},
        {{150, 100}, {200, 150}},
        {{200, 100}, {250, 150}},
        {{100, 200}, {150, 250}}
      ]
    }
  end

  @tag skip: "nao foi possivel testar porque ele cria a imagem"
  test "metodo que desenha a imagem" do
    hex = Identicon.hash_input("banana")
    map = Identicon.pick_color(hex)
    hash = Identicon.build_grid(map)
    filter = Identicon.filter_odd_squares(hash)
    build = Identicon.build_pixel_map(filter)
    draw = Identicon.draw_image(build)
    assert draw == "<<137, 80, 78, 71, 13, 10, 26, 10, 0, 0, 0, 13, 73, 72, 68, 82, 0, 0, 0, 250, 0,
    0, 0, 250, 8, 2, 0, 0, 0, 7, 142, 205, 106, 0, 0, 6, 155, 73, 68, 65, 84, 120,
    156, 237, 212, 209, 105, 37, 49, 20, ...>>"
  end

  test "metodo que salva a imagem criada" do
    hex = Identicon.hash_input("banana")
    map = Identicon.pick_color(hex)
    hash = Identicon.build_grid(map)
    filter = Identicon.filter_odd_squares(hash)
    build = Identicon.build_pixel_map(filter)
    draw = Identicon.draw_image(build)
    save = Identicon.save_image(draw, "filename")
    assert save == :ok
    assert File.exists?("/Users/ana.eusebio/elixirschool/identicon/filename.png")
  end

end
