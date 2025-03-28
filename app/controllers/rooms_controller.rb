class RoomsController < ApplicationController
    before_action :authenticate_user!  # ログインしていることを確認

    def own
        @rooms = current_user.rooms
    end

    def index
        @rooms = Room.all
  
        if params[:address].present? && params[:keyword].present?
            @rooms = @rooms.search_by_address_and_keyword(params[:address], params[:keyword])
        elsif params[:address].present?
            @rooms = @rooms.search_by_address(params[:address]) 
        elsif params[:keyword].present?
            @rooms = @rooms.search_by_name_or_description(params[:keyword])
        end
      
        # 施設の件数
        @room_count = @rooms.count
    end

    def new
        @room = Room.new
    end

    def create
        @room = current_user.rooms.build(room_params)

        if @room.save
            flash[:notice] = "新規施設登録が完了しました"
            redirect_to own_room_rooms_path
        else
            flash[:alert] = "新規施設登録に失敗しました"
            render :new
        end
    end

    def show
        @room =Room.find(params[:id])
        @reservation = Reservation.new
    end

    def edit
        @room =Room.find(params[:id])
    end

    def update
        @room =Room.find(params[:id])
        if @room.update(room_params)
            flash[:notice] = "施設情報が更新されました"
            redirect_to own_room_rooms_path
        else
            flash[:alert] = "施設情報の更新に失敗しました"
            render :edit
        end
    end

    def destroy
        @room =Room.find(params[:id])
        @room.destroy
        flash[:notice] = "登録されていた施設を削除しました"
        redirect_to own_room_rooms_path
    end

    def room_params
        params.require(:room).permit(:name, :description, :price, :address, :image)
    end
end
