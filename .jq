# from https://gist.github.com/reegnz/5bceb53427008a4ff9367eb8eae97b85
# with these in place, you can do 
# jq 'map_keys(camel_to_snake)'

def map_keys(mapper):
  walk(
    if type == "object"
    then
      with_entries({
        key: (.key|mapper),
    value
      })
    else .
    end
  );

def camel_to_snake:
  [
    splits("(?=[A-Z])")
  ]
  |map(
    select(. != "")
    | ascii_downcase
  )
  | join("_");

def snake_to_camel:
  split("_")
  | map(
    split("")
    | .[0] |= ascii_upcase
    | join("")
  )
  | join("");
