[
  (loop_generate_construct)
  (loop_statement)
  (conditional_statement)
  (case_item)
  (function_declaration)
  (always_construct)
  (module_declaration)
] @local.scope

(data_declaration
  (list_of_variable_decl_assignments
    (variable_decl_assignment
      (simple_identifier) @local.definition.var)))

(genvar_initialization
  (genvar_identifier
    (simple_identifier) @local.definition.var))

(for_initialization
  (for_variable_declaration
    (simple_identifier) @local.definition.var))

(net_declaration
  (list_of_net_decl_assignments
    (net_decl_assignment
      (simple_identifier) @local.definition.var)))

(ansi_port_declaration
  (port_identifier
    (simple_identifier) @local.definition.var))

(parameter_declaration
  (list_of_param_assignments
    (param_assignment
      (parameter_identifier
        (simple_identifier) @local.definition.parameter))))

(local_parameter_declaration
  (list_of_param_assignments
    (param_assignment
      (parameter_identifier
        (simple_identifier) @local.definition.parameter))))

; TODO: fixme
;(function_declaration
;(function_identifier
;(simple_identifier) @local.definition.function))
(function_declaration
  (function_body_declaration
    (function_identifier
      (function_identifier
        (simple_identifier) @local.definition.function))))

(tf_port_item1
  (port_identifier
    (simple_identifier) @local.definition.parameter))

; too broad, now includes types etc
(simple_identifier) @local.reference
