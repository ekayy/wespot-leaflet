class PlacesController < ApplicationController
  helper_method :near_column

  def index

    if params[:query].present?
      @places = Place.near(near_column, 4, :order => :distance).where("business_name @@ :q", q: params[:query]) | Place.tagged_with(params[:query]).filter(params[:sort])
    elsif params[:query_location].present?
      @places = Place.near(params[:query_location], 1, :order => :distance).filter(params[:sort])

    #   respond_to do |format|
    #     format.html {
    #       @places = Kaminari.paginate_array(@places).page(params[:page]).per(15)
    #     }
    #     format.json {
    #       render :json => @places
    #       # @places = Kaminari.paginate_array(@json)
    #       # @places = @json.page(params[:page]).per(15)
    #     }

    # end
    else

      center_point = [params[:lat].to_f, params[:lng].to_f]
      box = Geocoder::Calculations.bounding_box(center_point, 1)
      @places = Place.within_bounding_box(box)
      # @places = Place.near(near_column, 50, :order => :distance)
      # respond_to do |format|
      #   format.html
      #   format.json { render :json => @places }
      # end
    end
    @places = Kaminari.paginate_array(@places).page(params[:page]).per(15)


    respond_to do |format|
        format.html {
          @json = @places.to_gmaps4rails do |place, marker|
            marker.title   place.business_name
            marker.json({:longitude => place.longitude,
                             :latitude => place.latitude,
                             :id => place.id })
          end

        }
        format.json {
          @json = @places.to_gmaps4rails do |place, marker|
            # marker.infowindow render_to_string(:partial => "/places/infowindow", :locals => { :object => place})
            marker.title   place.business_name
            marker.json({:longitude => place.longitude,
                             :latitude => place.latitude,
                             :id => place.id })
          end
          render :json => @json
          # @places = Kaminari.paginate_array(@json)
          # @places = @json.page(params[:page]).per(15)
        }

    end

  end

  def show
  	@place = Place.find(params[:id])
  	@commentable = @place
  	@comments = @commentable.comments
  	@comment = Comment.new
    @dishes = @place.dishes
    @twitter = Twitter.user_timeline(@place.twitterid, :count => 1, :include_entities => true)
    if @place.latitude.nil?
      @instagram  = Instagram.media_search(20, 32)
    else
      begin
      # @instagram = Instagram.media_search(@place.latitude, @place.longitude, { :distance => 10 })
      @instagram = Instagram.tag_recent_media(@place.instagramid)
      rescue
        @instagram = Instagram.tag_recent_media('wespot')
      end
    end
  end

  def vote
    value = params[:type] == "up" ? 1 : -1
    @place = Place.find(params[:id])
    @place.add_or_update_evaluation(:votes, value, current_user)
    redirect_to :back, notice: "Thank you for voting!"
  end

  # def feed
  #   # @recentcomments = Comment.order('created_at DESC').limit(10)
  #   # @recentcomments = Comment.all(:order => 'created_at DESC', :limit => 10)
  #   @instagram = Instagram.tag_recent_media('wespot')
  #   # @feed = [ Comment ].inject([ ]) do |a, with_class|
  #   #    a + with_class.find(:all, :limit => 10, :order => 'created_at DESC')end.sort_by(&:created_at).reverse[0, 10]
  #   @comments = Comment.all(:order => 'created_at DESC', :limit => 10)
  #   @feed_items = current_user.feed


  #   order_by = "created_at DESC" if params[:sort] == "created_at"
  #     @test = Comment.all(:order => order_by)

  #     @feeds = Place.popular[0..9]
  # end

  def lightbox
    @place = Place.find(params[:id])
    @twitter = Twitter.user_timeline(@place.twitterid, :count => 1)
    render :layout => false
  end

  private
    def near_column
      if params[:query_location].present?
        params[:query_location]
      else
        "San Francisco"
      end
    end
end
