defmodule PhxPackingListWeb.Router do
  use PhxPackingListWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {PhxPackingListWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PhxPackingListWeb do
    pipe_through :browser

    get "/", PageController, :home

    resources "/packing_lists", PackingListController do
      resources "/items", ItemController, only: [:index, :new, :create, :edit, :update, :delete]
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", PhxPackingListWeb do
  #   pipe_through :api
  # end
end
