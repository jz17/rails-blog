class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource  only: [:edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @user = current_user
    @post = Post.find(params[:id])
  end

  # GET /posts/new
  def new
    @post = Post.new(user_id: current_user.id)
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def update
    @post.user_id = current_user.id

    respond_to do |format|
      if can_update
        if @post.update(post.params)
          if @post.save
            format.html { redirect_to @post, notice: 'Post was successfully created.' }
            format.json { render :show, status: :created, location: @post }
          else
            format.html { render :new }
            format.json { render json: @post.errors, status: :unprocessable_entity }
          end
        else
          format.html { redirect_to @post, alert: 'Posts was unsuccessfully updated' }
          format.json { render :show, status: :ok, location: @post}
        end
      end
    end
  end


  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    can_update = @post.user_id == current_user.id
    
    respond_to do |format|
      if can_update
        if @post.update(post_params)
          format.html { redirect_to @post, notice: 'Post was successfully updated.' }
          format.json { render :show, status: :ok, location: @post }
        else
          format.html { render :edit }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :body, :category_id, :user_id)
    end
end
