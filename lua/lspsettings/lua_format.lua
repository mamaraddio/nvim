return {
  -- see https://github.com/CppCXY/EmmyLuaCodeStyle

  -- optional space/tab
  indent_style = '"space"',
  -- if indent_style is space, this is valid
  indent_size = 4,
  -- if indent_style is tab, this is valid
  tab_width = 4,
  -- none/single/double
  quote_style = "none",

  continuation_indent = 4,
  ---- extend option
  -- continuation_indent.before_block = 4
  -- continuation_indent.in_expr = 4
  -- continuation_indent.in_table = 4

  -- this mean utf8 length , if this is 'unset' then the line width is no longer checked
  -- this option decides when to chopdown the code
  max_line_length = 120,

  -- optional crlf/lf/cr/auto, if it is 'auto', in windows it is crlf other platforms are lf
  -- in neovim the value 'auto' is not a valid option, please use 'unset'
  end_of_line = "unset",

  --  none/ comma / semicolon / only_kv_colon
  table_separator_style = "comma",

  --optional keep/never/always/smart
  trailing_table_separator = "smart",

  -- keep/remove/remove_table_only/remove_string_only
  call_arg_parentheses = "always",

  detect_end_of_line = false,

  -- this will check text end with new line
  insert_final_newline = true,

  -- [space]
  space_around_table_field_list = true,

  space_before_attribute = true,

  space_before_function_open_parenthesis = false,

  space_before_function_call_open_parenthesis = false,

  space_before_closure_open_parenthesis = true,

  -- optional always/only_string/only_table/none
  -- or true/false
  space_before_function_call_single_arg = false,
  ---- extend option
  ---- always/keep/none
  -- space_before_function_call_single_arg.table = "always"
  ---- always/keep/none
  -- space_before_function_call_single_arg.string = "always"

  space_before_open_square_bracket = false,

  space_inside_function_call_parentheses = true,

  space_inside_function_param_list_parentheses = true,

  space_inside_square_brackets = true,

  -- like t[--t+1] = 1
  space_around_table_append_operator = false,

  ignore_spaces_inside_function_call = false,

  -- detail number or 'keep'
  space_before_inline_comment = 1,

  -- convert '---' to '--- ' or '--' to '-- '
  space_after_comment_dash = true,

  -- [operator space]
  space_around_math_operator = true,
  -- space_around_math_operator.exponent = false

  space_after_comma = true,

  space_after_comma_in_for_statement = true,

  -- true/false or none/always/no_space_asym
  space_around_concat_operator = true,

  space_around_logical_operator = true,

  -- true/false or none/always/no_space_asym
  space_around_assign_operator = true,

  -- [align]

  align_call_args = true,

  align_function_params = true,

  -- true/false or always
  align_continuous_assign_statement = true,

  align_continuous_rect_table_field = true,

  align_continuous_line_space = 2,

  align_if_branch = true,

  -- option none / always / contain_curly/
  align_array_table = true,

  align_continuous_similar_call_args = true,

  align_continuous_inline_comment = true,
  -- option none / always / only_call_stmt
  align_chain_expr = "only_call_stmt",

  -- [indent]

  never_indent_before_if_condition = false,

  never_indent_comment_on_if_branch = false,

  keep_indents_on_empty_lines = false,

  allow_non_indented_comments = false,
  -- [line space]

  -- The following configuration supports four expressions
  -- keep
  -- fixed(n)
  -- min(n)
  -- max(n)
  -- for eg. min(2)

  line_space_after_if_statement = 1,

  line_space_after_do_statement = 1,

  line_space_after_while_statement = 1,

  line_space_after_repeat_statement = 1,

  line_space_after_for_statement = 1,

  line_space_after_local_or_assign_statement = "keep",

  line_space_after_function_statement = 2,

  line_space_after_expression_statement = "keep",

  line_space_after_comment = "keep",

  line_space_around_block = 1,

  -- [line break]
  break_all_list_when_line_exceed = true,

  auto_collapse_lines = true,

  break_before_braces = true,

  -- [preference]
  ignore_space_after_colon = false,

  remove_call_expression_list_finish_comma = false,
  -- keep / always / same_line / replace_with_newline / never
  end_statement_with_semicolon = "same_line",
}
