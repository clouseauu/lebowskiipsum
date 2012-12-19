class LebowskiIpsum

  LOREM_IPSUM = 'dolor sit amet, consectetur adipiscing elit praesent ac magna justo pellentesque ac lectus quis elit blandit fringilla a ut turpis praesent felis ligula, malesuada suscipit malesuada non, ultrices non urna sed orci ipsum, placerat id condimentum rutrum, rhoncus ac lorem aliquam placerat posuere neque, at dignissim magna ullamcorper in aliquam sagittis massa ac tortor ultrices faucibus curabitur eu mi sapien, ut ultricies ipsum morbi eget risus nulla nullam vel nisi enim, vel auctor ante morbi id urna vel felis lacinia placerat vestibulum turpis nulla, viverra nec volutpat ac, ornare id lectus cras pharetra faucibus tristique nullam non accumsan justo nulla facilisi integer interdum elementum nulla, nec eleifend nisl euismod ac maecenas vitae eros velit, eu suscipit erat integer purus lacus, pretium vel venenatis eu, volutpat non erat donec a metus ac eros dictum aliquet nulla consectetur egestas placerat maecenas pulvinar nisl et nisl rhoncus at volutpat felis blandit in libero turpis, laoreet et molestie sed, volutpat et erat nulla ut orci quis neque consectetur tincidunt aliquam erat volutpat donec aliquam orci eget mi lobortis sed tincidunt diam mattis fusce sem quam, ultricies sed convallis ac, hendrerit eu urna curabitur varius egestas nibh id lacinia vestibulum laoreet lobortis massa nec condimentum aliquam erat volutpat nullam ornare ipsum ut magna ultricies sed laoreet velit tincidunt ut vehicula est a est ultricies viverra mauris vitae risus ut ipsum suscipit dignissim ut convallis tortor ac quam tristique eget commodo diam vestibulum nulla facilisi morbi porttitor, orci nec adipiscing semper, ligula nisl hendrerit tortor, sit amet condimentum leo elit in lacus quisque posuere orci eu tortor commodo condimentum curabitur porta porttitor nunc eu faucibus in hac habitasse platea dictumst sed eros lorem, mattis eu sagittis aliquet, vehicula id tellus cras vehicula tincidunt rutrum ut id erat in libero porttitor ornare at et est suspendisse sed magna ac enim mollis convallis integer aliquam adipiscing sodales curabitur facilisis porttitor enim quis scelerisque pellentesque ullamcorper ligula sit amet dolor faucibus facilisis in lacus quam, volutpat in adipiscing eget, blandit et eros integer vehicula vehicula elit eget vulputate cras at sollicitudin augue maecenas vulputate est a neque sagittis commodo quisque condimentum posuere iaculis fusce at rhoncus nisl sed at orci sed urna accumsan vehicula nullam urna libero, eleifend ac interdum ut, consequat in leo proin in tortor risus sed augue urna, hendrerit nec hendrerit hendrerit, auctor non odio nulla facilisi nulla ac lectus mauris, sed ultrices ante sed pellentesque, nulla non commodo rutrum, magna est sollicitudin dolor, sed dignissim metus eros in est morbi dictum, nulla ultrices vestibulum bibendum, nunc purus imperdiet augue, sit amet interdum ante purus at quam ut nulla sapien, facilisis in commodo vel, lobortis ut sem fusce et leo ipsum donec tincidunt adipiscing tortor non commodo integer et nunc vel ligula imperdiet porta aenean in urna sed urna sagittis tempor sed cursus lectus nam nec ipsum at elit condimentum consectetur'

  def initialize quotes=nil, options=nil
    @quotes = quotes
    @options = options
    @lorem_array = []
    @lorem = []
    @lipsum = []
  end


  def lorem_ipsum number, type = 'paragraphs'

    @lorem_array = make_lorem_array if @lorem_array.empty?
    @lorem.clear

    number.times do

      words = type == 'sentences' ? words_per_sentence : words_per_paragraph
      @lorem_array.push( make_lorem_array ).flatten! if @lorem_array.count < words
      @lorem.push @lorem_array.shift(words).join(' ').capitalize.sub(/([,]{1})$/, '').concat '.'

    end

    prepend_lorem_ipsum :lorem if type != 'sentences'
    @lorem
  end


  def lebowski_ipsum paragraphs

    return ["Dios mio, man. You broke the app! Tweak your options to get some text."] if @quotes.empty?

    quote_pool = @quotes.shuffle; @lipsum.clear # the pool is reduced as quotes are used

    paragraphs.times do

      enough_words = false; sentences = []

      until enough_words

        sentences.push quote_pool.shift.quote
        sentences.push( lorem_ipsum(1, 'sentences')[0] ) if @options[:mixed]
        quote_pool = @quotes.shuffle if quote_pool.count < 1
        enough_words = true if LEBOWSKI_OPTIONS[:min_words] < sentences.inject('') { |s,n| s.concat("#{n} ") }.strip.split(' ').count

      end
      @lipsum.push format_sentences sentences
    end

    prepend_lorem_ipsum :lebowski
    wrap_in_tags

    @lipsum
  end


  private

    def words_per_paragraph
      (LEBOWSKI_OPTIONS[:min_words]..LEBOWSKI_OPTIONS[:max_words]).to_a.sample
    end

    def words_per_sentence
      (LEBOWSKI_OPTIONS[:min_sentence]..LEBOWSKI_OPTIONS[:max_sentence]).to_a.sample
    end

    def make_lorem_array
      LOREM_IPSUM.split ' '
    end

    def prepend_lorem_ipsum key = :lebowski
      if key == :lebowski
        @lipsum[0].insert 0, "Lebowski ipsum " if @options[:startleb]
      else
        @lorem[0].insert 0, "Lorem ipsum " if @options[:startleb]
      end
    end

    def wrap_in_tags
      @lipsum.map { |s| s.insert(0, '<p>').concat '</p>' } if @options[:html]
    end

    def format_sentences sentences
      sentences.map do | s |
        s.strip!
        s.concat '.' unless s.match /([\.\?!,]{1})$/
        s.slice(0,1).capitalize + s.slice(1..-1) unless s.match /([,]{1})$/
      end.join ' '
    end

end