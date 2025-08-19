(parameters
   "(" @delimiter
   ")" @delimiter @sentinel) @container

(arguments
   "(" @delimiter
   ")" @delimiter @sentinel) @container

(if_statement
   "(" @delimiter
   ")" @delimiter @sentinel) @container

(if_expression
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(if_type_expression
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(for_statement
   "(" @delimiter
   ")" @delimiter @sentinel) @container

(for_expression
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(while_statement
  "(" @delimiter
  .
  condition: (_)
  .
  ")" @delimiter @sentinel ;; keep the sentinel for fallback
  (
    ":" @delimiter
    "(" @delimiter
    ")" @delimiter
  )?
) @container

(while_expression
  "(" @delimiter
  .
  condition: (_)
  .
  ")" @delimiter @sentinel ;; keep the sentinel for fallback
  (
  ":" @delimiter
  "(" @delimiter
  ")" @delimiter
  )?
) @container

(link_section
   "(" @delimiter
   ")" @delimiter @sentinel) @container

(calling_convention
   "(" @delimiter
   ")" @delimiter @sentinel) @container

(asm_expression
   "(" @delimiter
   ")" @delimiter @sentinel) @container

(asm_input_item
   "[" @delimiter
   "]" @delimiter
   "(" @delimiter
   ")" @delimiter @sentinel) @container

(asm_output_item
   "[" @delimiter
   "]" @delimiter
   "(" @delimiter
   ")" @delimiter @sentinel) @container

(switch_expression
   "(" @delimiter
   ")" @delimiter
   "{" @delimiter
   ((switch_case
     "=>" @delimiter)
   _)+
   "}" @delimiter @sentinel) @container

(array_type
   "[" @delimiter
   "]" @delimiter @sentinel) @container

(slice_type
   "[" @delimiter
   "]" @delimiter @sentinel) @container

(index_expression
   "[" @delimiter
   "]" @delimiter @sentinel) @container

(pointer_type
  (
    "(" @delimiter
    ")" @delimiter @sentinel ;; keep the sentinel for fallback
  )?
  (
    "[" @delimiter
    "]" @delimiter @sentinel ;; keep the sentinel for fallback
  )?
) @container

(block
   "{" @delimiter
   "}" @delimiter @sentinel) @container

(initializer_list
   "{" @delimiter
   "}" @delimiter @sentinel) @container

(payload
  .  ;; Without the anchor the @delimiter will be matched three times
  "|" @delimiter
  "|" @delimiter @sentinel) @container

(call_expression
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(opaque_declaration
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(struct_declaration
  (
    "(" @delimiter
    ")" @delimiter
  )?
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(enum_declaration
  (
    "(" @delimiter
    ")" @delimiter
  )?
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(union_declaration
  (
    "(" @delimiter
    ")" @delimiter
  )?
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(parenthesized_expression
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(error_set_declaration
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(byte_alignment
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(address_space
  "(" @delimiter
  ")" @delimiter @sentinel) @container
