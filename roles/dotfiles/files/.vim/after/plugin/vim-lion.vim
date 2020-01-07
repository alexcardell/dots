" Options
" | Option                | Description                      | Default |
" | g:lion_create_maps    | Whether to create mappings       | 1       |
" | g:lion_squeeze_spaces | Squeeze extra spaces             | 0       |
" | g:lion_map_right      | Mapping for right-align operator | gl      |
" | g:lion_map_left       | Mapping for left-align operator  | gL      |
"
" If you set: let b:lion_squeeze_spaces = 1, and hit glip=, you will turn
"
" $i      = 5;
" $user     = 'tommcdo';
" $stuff  = array(1, 2, 3);
"
" into:
"
" $i     = 5;
" $user  = 'tommcdo';
" $stuff = array(1, 2, 3);
"
" instead of b:lion_squeeze_spaces = 0:
"
" $i        = 5;
" $user     = 'tommcdo';
" $stuff    = array(1, 2, 3);

let g:lion_squeeze_spaces = 1
