defmodule KeyValueStore do
  use GenServer

  def start do
    GenServer.start(KeyValueStore, nil, name: KeyValueStore)
  end

  def put(key, value) do
    GenServer.cast(KeyValueStore, {:put, key, value})
  end

  def get(key) do
    GenServer.call(KeyValueStore, {:get, key})
  end

  def init(_) do
    {:ok, %{}}
  end

  def handle_cast({:put, key, value}, state) do
    {:noreply, Map.put(state, key, value)}
  end

  def handle_call({:get, key}, _, state) do
    {:reply, Map.get(state, key), state}
  end
end
