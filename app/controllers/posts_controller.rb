class PostsController < ApplicationController
  # GET /posts
  def index
    # raise UserIsNotAdmin

    # @posts = Post.page(params[:page]).select(params[:fields])#.per(10)
    @posts = Post.all

    # render json: ActiveModel::Serializer::CollectionSerializer.new(@posts, each_serializer: PostSerializer)
    render json: @posts
    # render json: @posts, links: { self: posts_url, meta: { pages: 10 } }
  end

  # GET /posts/1
  def show
    post = find_post
    # if stale?(last_modified: post.updated_at)
    #   render json: post
    # end
    # render json: PostSerializer.new(post)
    render json: post
  end

  # POST /posts
  def create
    @post = Post.new(post_params)

    if @post.save
      render json: @post, status: :created
    else
      render json: { errors: @post.errors }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update
    post = find_post
    post.update!(post_params)
    render json: post
  end

  # DELETE /posts/1
  def destroy
    post = find_post
    post.destroy
    render json: { }, status: :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def find_post
      Post.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def post_params
      params.require(:post).permit(:title, :body)
    end
end
