module EventsHelper
  def create_data
    list_content = ["Chúc mừng cô nhân ngày 20/10. Kính chúc cô luôn mạnh khoẻ, hạnh phúc, thành công trong cuộc sống. Chúng em xin gửi đến cô những tình cảm sâu sắc và lòng biết ơn chân thành nhất. Cảm ơn cô đã luôn sát cánh bên chúng em, động viên chúng em trong những chặng đường học tập đầy khó khăn.","Nhân ngày Phụ nữ Việt Nam, em xin gửi tới cô lời chúc tốt đẹp nhất. Chúc cô luôn mạnh khỏe, vui tươi và có thật nhiều những chuyến đò thành công. Cảm ơn cô đã luôn quan tâm và dìu dắt em trong những năm học vừa qua.","Nhân ngày Phụ nữ Việt Nam, em muốn gửi đến cô tất cả tấm chân tình của em, kính chúc cô luôn vui vẻ, tràn ngập niềm vui trong cuộc sống và thành công trong sự nghiệp trồng người của mình. Em mong cô luôn giữ vững tình yêu với nghề giáo để mang đến cho những thế hệ sau những bài học tuyệt vời như chúng em đã được tiếp thu.","Thay mặt các bạn nam trong lớp, em xin gửi tới cô lời chúc mừng nồng nhiệt nhất. Chúc cô luôn xinh đẹp, tươi vui và hạnh phúc không chỉ riêng ngày 20 tháng 10 này! Cảm ơn cô đã luôn quan tâm và giúp đỡ chúng em.","Cảm ơn cô đã luôn sát cánh bên chúng em trên chặng đường chinh phục tri thức. Chúc cô có một ngày 20 tháng 10 vui vẻ, ý nghĩa. Chúng em yêu cô!","Nhân ngày Phụ nữ Việt Nam, con chúc cô luôn mạnh khỏe, hạnh phúc và thành công trong sự nghiệp trồng người!","Đối với chúng em, cô như một người mẹ thứ 2 vậy. Nhân ngày Phụ nữ Việt Nam, chúng em luôn mong cô mạnh khỏe, hạnh phúc và luôn vững niềm tin để chèo lái nhiều chuyến đò cập bến hơn nữa. Chúng em yêu cô rất nhiều!","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""]
    order = 23
    category_id = 3

    list_content.each do |content|
      next if content == ""

      order+=1
      Wish.create(category_id: category_id, context: content, status: 1, user_id: 1, order: order,created_at: Date.current, updated_at: Date.current)
    end

    list_content = ["Nhân ngày Phụ nữ Việt Nam xin gửi những lời chúc nồng nhiệt nhất đến toàn thể các bạn nữ. Chúc các bạn ngày một xinh đẹp để ngày càng có thêm nhiều chàng trai đeo bám nhằng nhằng như lửa bám xăng, như răng bám lợi, như trời bám mây, như cây bám đất, như bít tất bám... bàn chân!","Nhân ngày 20/10, xin được chúc tất cả các bạn nữ hay ăn chóng lớn và học tập tốt, lao động tốt phấn đấu trở thành người phụ nữ giỏi việc nước, đảm việc nhà.","Thay mặt hội những người hay mặc quần đùi, tôi xin gửi tới những người phụ nữ xinh đẹp ở đây lời chúc mừng nồng nhiệt nhất. Chúc các chị em luôn xinh đẹp, trẻ trung, vui tươi và ngập tràn hạnh phúc. Chúc mừng ngày Phụ nữ Việt Nam!","Nhân ngày Phụ nữ Việt Nam. Tôi xin chúc các chị em đồng nghiệp mãi xinh đẹp, luôn giỏi việc nước, đảm việc nhà và hăng hái trong mọi cuộc chơi.","Tôi xin thay mặt hội trai đẹp của công ty, chúc các chị em có một ngày 20 tháng 10 ngập tràn niềm vui và hạnh phúc. Chúc các chị em luôn xinh đẹp, tươi trẻ và nhận được thật nhiều quà nhé!","Ngày Phụ nữ Việt Nam 20/10 - Chúc chị em nhận được nhiều quà, nhiều hoa nhiều lời khen lời chúc của phái nam trong ngày hôm nay. Chúc chị em có một ngày 20/10 thật là ý nghĩa, vui tươi ngập tràn hạnh phúc.","Chúc những người chị, người em đồng nghiệp của tôi có một ngày 20 tháng 10 vui vẻ, hạnh phúc. Hãy luôn nở nụ cười tươi và gặp nhiều may mắn trong công việc cũng như cuộc sống chị em nhé!","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""]
    category_id = 4

    list_content.each do |content|
      next if content == ""

      order+=1
      Wish.create(category_id: category_id, context: content, status: 1, user_id: 1, order: order,created_at: Date.current, updated_at: Date.current)
    end

    list_content = ["Chúc mày - con bạn thân nhất của tao có một ngày 20 tháng 10 thật vui vẻ nhé. Nếu nhận được nhiều quà quá thì có thể chia sẻ bớt cho tao cũng được.","Thay mặt các bạn nam, tớ xin được gửi lời chúc mừng thân thương tới một nửa xinh đẹp của lớp mình. Chúc các bạn luôn xinh đẹp, giỏi giang và nhận được thật nhiều quà trong ngày hôm nay. Chúc mừng ngày Phụ nữ Việt Nam!","Chúc bạn của tớ sẽ nhận được thật nhiều hoa và quà trong ngày hôm nay nhé. Chúc cậu luôn vui tươi, trẻ trung, học giỏi. Chúc mừng ngày Phụ nữ Việt Nam!","Nhân ngày Phụ nữ Việt Nam. Tớ thay mặt các hotboy của lớp chúc các hotgirl luôn xinh, thông minh và vui tính nhé! Happy Viet Nam Women's Day!","Chúc bạn luôn cười tươi, cười duyên, cười e thẹn, cười trẻ trung và cười hoài trong ngày hôm nay 20/10.","Chúc con bạn thân nhất của tao có một ngày 20/10 thật vui vẻ, ý nghĩa nhé. Nếu nhận được nhiều quà quá thì có thể chia sẻ bớt cho tao cũng được, hehe.","Chúc các bạn nữ luôn tươi cười như hít phải khí N2O","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""]
    category_id = 5

    list_content.each do |content|
      next if content == ""

      order+=1
      Wish.create(category_id: category_id, context: content, status: 1, user_id: 1, order: order,created_at: Date.current, updated_at: Date.current)
    end

    list_content = ["Kính chúc Quý khách hàng có một ngày 20/10 ý nghĩa, vui vẻ và ngập tràn yêu thương. Chân thành cảm ơn Quý khách hàng đã gắn bó, đồng hành cùng chúng tôi trong suốt thời gian qua.","Cảm ơn Quý khách hàng đã luôn tín nhiệm và ủng hộ sản phẩm/dịch vụ của chúng tôi suốt thời gian qua. Nhân ngày 20/10, xin gửi tới Quý khách lời cảm ơn cũng như những lời chúc tốt đẹp nhất. Chúc bạn và gia đình luôn khỏe mạnh, vui vẻ! Trân trọng!","Xin gửi tới Quý khách hàng những câu chúc 20/10 hay nhất. Chúc bạn ngày càng xinh đẹp, trẻ trung và gặt hái được nhiều thành công trong công việc, cuộc sống!","Nhân ngày Phụ nữ Việt Nam, chúng tôi xin dành những điều tốt đẹp nhất tới bạn. Chúc bạn có một ngày 20/10 ngập tràn niềm vui và hạnh phúc!","Chúc mừng ngày Phụ nữ Việt Nam! Chúc cho những dự định trong tương lai của bạn luôn thành công! Cảm ơn bạn đã tin tưởng và ủng hộ chúng tôi trong suốt thời gian vừa qua.","Nhân ngày Phụ nữ Việt Nam, chúng tôi muốn gửi tới Quý khách hàng lời chúc chân thành và thân thương nhất! Chúc bạn có một ngày 20/10 ý nghĩa, trọn vẹn và thật nhiều yêu thương. Cảm ơn bạn đã luôn đồng hành cùng chúng tôi!","Nhân ngày Phụ nữ Việt Nam, chúng tôi muốn gửi tới Quý khách hàng lời chúc chân thành và thân thương nhất! Chúc bạn có một ngày 20/10 ý nghĩa, trọn vẹn và thật nhiều yêu thương. Cảm ơn bạn đã luôn đồng hành cùng chúng tôi!","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""]
    category_id = 6

    list_content.each do |content|
      next if content == ""

      order+=1
      Wish.create(category_id: category_id, context: content, status: 1, user_id: 1, order: order,created_at: Date.current, updated_at: Date.current)
    end
  end
end
