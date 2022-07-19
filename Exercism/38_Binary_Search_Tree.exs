defmodule BinarySearchTree do
  @type bst_node :: %{data: any, left: bst_node | nil, right: bst_node | nil}

  @doc """
  Create a new Binary Search Tree with root's value as the given 'data'
  """
  @spec new(any) :: bst_node
  def new(data) do
    %{data: data, left: nil, right: nil}
  end

  @doc """
  Creates and inserts a node with its value as 'data' into the tree.
  """
  @spec insert(bst_node, any) :: bst_node
  def insert(%{data: val, right: r_node} = tree, data) when data > val and is_nil(r_node) do
    Map.put(tree, :right, %{data: data, left: nil, right: nil})
  end

  def insert(%{data: val, left: l_node} = tree, data) when data <= val and is_nil(l_node) do
    Map.put(tree, :left, %{data: data, left: nil, right: nil})
  end

  def insert(%{data: val} = tree, data) when data >= val do
    Map.put(tree, :right, insert(tree.right, data))
  end

  def insert(%{data: val} = tree, data) when data < val do
    Map.put(tree, :left, insert(tree.left, data))
  end

  @doc """
  Traverses the Binary Search Tree in order and returns a list of each node's data.
  """
  @spec in_order(bst_node) :: [any]
  def in_order(tree) do
    traverse(tree) |> List.flatten()
  end
  defp traverse(nil), do: []
  defp traverse(leaf) do
    [traverse(leaf.left), leaf.data, traverse(leaf.right)]
  end
end
