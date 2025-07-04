---@class NodeIterator
local NodeIterator = {}
NodeIterator.__index = NodeIterator

---@param nodes Node[]
---@return NodeIterator
function NodeIterator.builder(nodes)
  return setmetatable({
    nodes = nodes,
    _filter_hidden = function(node)
      return not node.hidden
    end,
    _apply_fn_on_node = function(_) end,
    _match = function(_) end,
    _recurse_with = function(node)
      return node.nodes
    end,
  }, NodeIterator)
end

---@return NodeIterator
function NodeIterator:hidden()
  self._filter_hidden = function(_)
    return true
  end
  return self
end

---@param f fun(node: Node): boolean
---@return NodeIterator
function NodeIterator:matcher(f)
  self._match = f
  return self
end

---@param f fun(node: Node, i: number)
---@return NodeIterator
function NodeIterator:applier(f)
  self._apply_fn_on_node = f
  return self
end

---@param f fun(node: Node): any
---@return NodeIterator
function NodeIterator:recursor(f)
  self._recurse_with = f
  return self
end

---@return Node|nil
---@return number
function NodeIterator:iterate()
  local iteration_count = 0
  local function iter(nodes)
    for _, node in ipairs(nodes) do
      if self._filter_hidden(node) then
        if not node.group_next then
          iteration_count = iteration_count + 1
        end
        if self._match(node) then
          return node, iteration_count
        end
        self._apply_fn_on_node(node, iteration_count)
        local children = self._recurse_with(node)
        if children then
          local n = iter(children)
          if n then
            return n, iteration_count
          end
        end
      end
    end
    return nil, 0
  end

  return iter(self.nodes)
end

return NodeIterator
