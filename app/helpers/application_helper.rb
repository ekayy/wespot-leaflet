module ApplicationHelper
  include Twitter::Autolink

	def show_user_bg
    "background:transparent url(#{@place.coverphoto.url}) no-repeat center;
    -webkit-background-size: cover;
		-moz-background-size: cover;
		-o-background-size: cover;
		background-size: cover;"
  end

  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = (column == sort_column) ? "current #{sort_direction}" : nil
    direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"
    link_to title, params.merge(:sort => column, :direction => direction, :page => nil), {:class => css_class}
  end

  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#', class: "add_fields btn", data: {id: id, fields: fields.gsub("\n", "")})
  end

  def options_for_hours_select
    [
      ['6 am',6],
      ['6:30 am',6.5],
      ['7 am',7],
      ['7:30 am',7.5],
      ['8 am',8],
      ['8:30 am',8.5],
      ['9 am',9],
      ['9:30 am',9.5],
      ['10 am',10],
      ['10:30 am',10.5],
      ['11 am',11],
      ['11:30 am',11.5],
      ['12 pm',12],
      ['12:30 pm',12.5],
      ['1 pm',13],
      ['1:30 pm',13.5],
      ['2 pm',14],
      ['2:30 pm',14.5],
      ['3 pm',15],
      ['3:30 pm',15.5],
      ['4 pm',16],
      ['4:30 pm',16.5],
      ['5 pm',17],
      ['5:30 pm',17.5],
      ['6 pm',18],
      ['6:30 pm',18.5],
      ['7 pm',19],
      ['7:30 pm',19.5],
      ['8 pm',20],
      ['8:30 pm',20.5],
      ['9 pm',21],
      ['9:30 pm',21.5],
      ['10 pm',22],
      ['10:30 pm',22.5],
      ['11 pm',23],
      ['11:30 pm',23.5],
      ['12 am',0],
      ['12:30 am',0.5],
      ['1 am',1],
      ['1:30 am',1.5],
      ['2 am',2],
      ['2:30 am',2.5],
      ['3 am',3],
      ['3:30 am',3.5],
      ['4 am',4],
      ['4:30 am',4.5],
      ['5 am',5],
      ['5:30 am',5.5]
    ]
  end
end