class RoomsController < ApplicationController
    
    def own 
        @rooms = current_user.rooms
    end

    def new
        @room = Room.new
    end

    def create
        @room = current_user.rooms.build(room_params)

        if @room.save
            flash[:notice] = "新規施設登録が完了しました"
            redirect_to room_path(@room)
        else
            render :new
        end
    end

    def show
        @room =Room.find(params[:id])
    end

    def edit
        @room =Room.find(params[:id])
    end

    def update
        @room =Room.find(params[:id])
        if @room.update(room_params)
            flash[:notice] = "施設情報が更新されました"
            redirect_to @room
        else
            flash[:notice] = "施設情報の更新に失敗しました"
            render :edit
        end
    end

    def destroy
        @room =Room.find(params[:id])
        @room.destory
        flash[:notice] = "登録されていた施設を削除しました"
        redirect_to own_room_path 
    end

    def room_params
        params.require(:room).permit(:name, :description, :price, :address, :image)
    end
end
