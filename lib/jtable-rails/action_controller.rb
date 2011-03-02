module JTable
  module ActionController
    def jtable_for_json(jtable_name, rel, jtable_params)
      jtable_params = HashWithIndifferentAccess.new(jtable_params)
      items = rel.send("jtable_#{jtable_name}_paginate",jtable_params[:limit], jtable_params[:offset])
      {:total_items => rel.count, :items => items.collect(&("jtable_#{jtable_name}_item").to_sym)}
    end
  end
end