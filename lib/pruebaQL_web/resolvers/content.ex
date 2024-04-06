defmodule PruebaQLWeb.Resolvers.Content do

  def list_links(_parent, _args, _resolution) do
    {:ok, PruebaQL.News.list_links()}
  end

  def get_link(_parent, %{id: id}, _resolution) do
    case PruebaQL.News.get_link!(id) do
      nil ->
        {:error, "User ID #{id} not found"}
      link ->
        {:ok, link}
    end
  end

  def create_link(_parent, args, _resolution) do
    case PruebaQL.News.create_link(args) do
      {:ok, link} ->
        {:ok, link}
      _error ->
        {:error, "could not create link"}
    end
  end

  def update_link(_parent,%{id: id, description: description}, _info) do
    case PruebaQL.News.get_link!(id) do
      nil ->
        {:error, "Link not found"}
        link ->
          {:ok, updated_link} = PruebaQL.News.update_link(link, %{description: description})
          {:ok, updated_link}
    end
  end

  def delete_link(_parent,%{id: id}, _info) do
    case PruebaQL.News.get_link!(id) do
      nil ->
        {:error, "Link not found"}
        link ->
        {:ok, _deleted_link} = PruebaQL.News.delete_link(link)
        {:ok, link}
    end
  end

end
