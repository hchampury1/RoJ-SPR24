# Added on 4/20/23 for CountySearchTerm Objects for Mapping Justice add/edit map data
class CountySearchTerm
    attr_reader :where_clause, :where_args, :order
    # Constructor for CountySearchTerm objects
    def initialize(search_term)
        search_term = search_term.downcase
        @where_clause = ""
        @where_args = {}
        build_for_name_search(search_term)
    end

    private

    def build_for_name_search(search_term)
        @where_clause << case_insensitive_search(:name)
        @where_args[:name] = starts_with(search_term)
        @order = "name asc"
    end

    def starts_with(search_term)
        search_term + "%"
    end

    def case_insensitive_search(name)
        "lower(#{name}) like :#{name}"
    end
end