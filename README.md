![](https://i.imgur.com/gIVzzvP.png)
# Identicon
> "An Identicon is a visual representation of a hash value, usually of an IP address, that serves to identify a user of a computer system as a form of avatar while protecting the users' privacy. The original Identicon was a 9-block graphic, and the representation has been extended to other graphic forms by third parties." – [Wikipedia](https://en.wikipedia.org/wiki/Identicon)

Built with guidance from Stephen Grider's Elixir course available on Udemy.com.
Uses the MD5 hashing algorithm to create a unique graphical identicon based on an input string.

# Project Overview
- Pattern matching within method arguments
- Greater understanding of the pipe operator and the way Elixir is meant to be used
- Mapping and iterating through Elixir data structures
- Better knowledge of Elixir library, e.g. Enum.chunk/2, Enum.filter/2, etc.

# Project Overview
- Pattern matching within method arguments
- Greater understanding of the pipe operator and the way Elixir is meant to be used
-Mapping and iterating through Elixir data structures
- Better knowledge of Elixir library, e.g. Enum.chunk/2, Enum.filter/2, etc.

# Elixir Code
The **main function** in the Identicon module is structured like so:
```
def main(input) do
  input
  |> hash_input
  # hashes the input string
  |> pick_color
  # takes first three integers for r, g, b color
  |> build_grid
  # chunks the list into 3's, flattens, then adds index to each element
  |> filter_odd_squares
  # filters out the odd numbers in the list
  |> build_pixel_map
  # maps coordinates for the colored squares
  |> draw_image
  # create image with Erlang egd
  |> save_image(input)
  # save the image to file
end
```

# Running the code
- Run iex -S mix in the directory, and opens the elixir terminal
- Run Identicon.main("your string")
- Find the image saved in the root directory
