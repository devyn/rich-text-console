# Autogenerated from a Treetop grammar. Edits may be lost.


require 'rubygems'
require 'treetop'
require 'cgi' # for escapeHTML

module RichTextConsole
  module RTDL
    include Treetop::Runtime

    def root
      @root || :document
    end

    module Document0
      def tags
        elements[1]
      end
    end

    module Document1
      def compile
        tags.elements.map { |t| t.represent }
      end
      def html
        s = ""
        compile.each do |sg|
          case sg
          when Hash
            sty = ""
            sg.each do |k,v|
              case k
              when 'fc'
                sty << "color:##{v.to_i(16).to_s(16)};"
              when 'bc'
                sty << "background-color:##{v.to_i(16).to_s(16)};"
              when 'b'
                sty << "font-weight:bold;"
              when 'i'
                sty << "font-style:italic;"
              when 'u'
                sty << "text-decoration:underline;"
              when 'fs'
                sty << "font-size:#{v.to_i}pt;"
              end
            end
            s << "<span style=\"#{sty}\">"
          when :end
            s << "</span>"
          else
            s << CGI.escapeHTML(sg).gsub("\n", "<br/>")
          end
        end
        return s
      end
    end

    def _nt_document
      start_index = index
      if node_cache[:document].has_key?(index)
        cached = node_cache[:document][index]
        @index = cached.interval.end if cached
        return cached
      end

      i0, s0 = index, []
      if has_terminal?("", false, index)
        r1 = instantiate_node(SyntaxNode,input, index...(index + 0))
        @index += 0
      else
        terminal_parse_failure("")
        r1 = nil
      end
      s0 << r1
      if r1
        s2, i2 = [], index
        loop do
          r3 = _nt_tag
          if r3
            s2 << r3
          else
            break
          end
        end
        if s2.empty?
          @index = i2
          r2 = nil
        else
          r2 = instantiate_node(SyntaxNode,input, i2...index, s2)
        end
        s0 << r2
      end
      if s0.last
        r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
        r0.extend(Document0)
        r0.extend(Document1)
      else
        @index = i0
        r0 = nil
      end

      node_cache[:document][start_index] = r0

      r0
    end

    module Tag0
    end

    module Tag1
      def represent
        :end
      end
    end

    module Tag2
    end

    module Tag3
      def option
        elements[0]
      end

    end

    module Tag4
      def options
        elements[1]
      end

    end

    module Tag5
      def represent
        Hash[options.elements.map {|o| o.option.pair }]
      end
    end

    module Tag6
      def represent
        text_value
      end
    end

    def _nt_tag
      start_index = index
      if node_cache[:tag].has_key?(index)
        cached = node_cache[:tag][index]
        @index = cached.interval.end if cached
        return cached
      end

      i0 = index
      i1, s1 = index, []
      if has_terminal?("\e[", false, index)
        r2 = instantiate_node(SyntaxNode,input, index...(index + 2))
        @index += 2
      else
        terminal_parse_failure("\e[")
        r2 = nil
      end
      s1 << r2
      if r2
        if has_terminal?("/", false, index)
          r3 = instantiate_node(SyntaxNode,input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure("/")
          r3 = nil
        end
        s1 << r3
        if r3
          if has_terminal?("]", false, index)
            r4 = instantiate_node(SyntaxNode,input, index...(index + 1))
            @index += 1
          else
            terminal_parse_failure("]")
            r4 = nil
          end
          s1 << r4
        end
      end
      if s1.last
        r1 = instantiate_node(SyntaxNode,input, i1...index, s1)
        r1.extend(Tag0)
        r1.extend(Tag1)
      else
        @index = i1
        r1 = nil
      end
      if r1
        r0 = r1
      else
        i5, s5 = index, []
        if has_terminal?("\e[", false, index)
          r6 = instantiate_node(SyntaxNode,input, index...(index + 2))
          @index += 2
        else
          terminal_parse_failure("\e[")
          r6 = nil
        end
        s5 << r6
        if r6
          s7, i7 = [], index
          loop do
            i8, s8 = index, []
            r9 = _nt_option
            s8 << r9
            if r9
              i10 = index
              i11, s11 = index, []
              if has_terminal?(',', false, index)
                r12 = instantiate_node(SyntaxNode,input, index...(index + 1))
                @index += 1
              else
                terminal_parse_failure(',')
                r12 = nil
              end
              s11 << r12
              if r12
                i13 = index
                r14 = _nt_option
                if r14
                  @index = i13
                  r13 = instantiate_node(SyntaxNode,input, index...index)
                else
                  r13 = nil
                end
                s11 << r13
              end
              if s11.last
                r11 = instantiate_node(SyntaxNode,input, i11...index, s11)
                r11.extend(Tag2)
              else
                @index = i11
                r11 = nil
              end
              if r11
                r10 = r11
              else
                if has_terminal?("", false, index)
                  r15 = instantiate_node(SyntaxNode,input, index...(index + 0))
                  @index += 0
                else
                  terminal_parse_failure("")
                  r15 = nil
                end
                if r15
                  r10 = r15
                else
                  @index = i10
                  r10 = nil
                end
              end
              s8 << r10
            end
            if s8.last
              r8 = instantiate_node(SyntaxNode,input, i8...index, s8)
              r8.extend(Tag3)
            else
              @index = i8
              r8 = nil
            end
            if r8
              s7 << r8
            else
              break
            end
          end
          if s7.empty?
            @index = i7
            r7 = nil
          else
            r7 = instantiate_node(SyntaxNode,input, i7...index, s7)
          end
          s5 << r7
          if r7
            if has_terminal?("]", false, index)
              r16 = instantiate_node(SyntaxNode,input, index...(index + 1))
              @index += 1
            else
              terminal_parse_failure("]")
              r16 = nil
            end
            s5 << r16
          end
        end
        if s5.last
          r5 = instantiate_node(SyntaxNode,input, i5...index, s5)
          r5.extend(Tag4)
          r5.extend(Tag5)
        else
          @index = i5
          r5 = nil
        end
        if r5
          r0 = r5
        else
          i17 = index
          if has_terminal?("\e", false, index)
            r18 = instantiate_node(SyntaxNode,input, index...(index + 1))
            @index += 1
          else
            terminal_parse_failure("\e")
            r18 = nil
          end
          if r18
            r17 = r18
            r17.extend(Tag6)
          else
            s19, i19 = [], index
            loop do
              if has_terminal?('\G[^\\e]', true, index)
                next_character = index + input[index..-1].match(/\A(.)/um).end(1)
                r20 = true
                @index = next_character
              else
                r20 = nil
              end
              if r20
                s19 << r20
              else
                break
              end
            end
            if s19.empty?
              @index = i19
              r19 = nil
            else
              r19 = instantiate_node(SyntaxNode,input, i19...index, s19)
            end
            if r19
              r17 = r19
              r17.extend(Tag6)
            else
              @index = i17
              r17 = nil
            end
          end
          if r17
            r0 = r17
          else
            @index = i0
            r0 = nil
          end
        end
      end

      node_cache[:tag][start_index] = r0

      r0
    end

    module Option0
      def name
        elements[0]
      end

      def value
        elements[2]
      end
    end

    module Option1
      def pair
        [name.text_value, value.text_value]
      end
    end

    module Option2
      def pair
        [text_value, nil]
      end
    end

    def _nt_option
      start_index = index
      if node_cache[:option].has_key?(index)
        cached = node_cache[:option][index]
        @index = cached.interval.end if cached
        return cached
      end

      i0 = index
      i1, s1 = index, []
      s2, i2 = [], index
      loop do
        if has_terminal?('\G[A-Za-z]', true, index)
          next_character = index + input[index..-1].match(/\A(.)/um).end(1)
          r3 = true
          @index = next_character
        else
          r3 = nil
        end
        if r3
          s2 << r3
        else
          break
        end
      end
      if s2.empty?
        @index = i2
        r2 = nil
      else
        r2 = instantiate_node(SyntaxNode,input, i2...index, s2)
      end
      s1 << r2
      if r2
        if has_terminal?("=", false, index)
          r4 = instantiate_node(SyntaxNode,input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure("=")
          r4 = nil
        end
        s1 << r4
        if r4
          s5, i5 = [], index
          loop do
            if has_terminal?('\G[^,\\]]', true, index)
              next_character = index + input[index..-1].match(/\A(.)/um).end(1)
              r6 = true
              @index = next_character
            else
              r6 = nil
            end
            if r6
              s5 << r6
            else
              break
            end
          end
          r5 = instantiate_node(SyntaxNode,input, i5...index, s5)
          s1 << r5
        end
      end
      if s1.last
        r1 = instantiate_node(SyntaxNode,input, i1...index, s1)
        r1.extend(Option0)
        r1.extend(Option1)
      else
        @index = i1
        r1 = nil
      end
      if r1
        r0 = r1
      else
        s7, i7 = [], index
        loop do
          if has_terminal?('\G[A-Za-z]', true, index)
            next_character = index + input[index..-1].match(/\A(.)/um).end(1)
            r8 = true
            @index = next_character
          else
            r8 = nil
          end
          if r8
            s7 << r8
          else
            break
          end
        end
        if s7.empty?
          @index = i7
          r7 = nil
        else
          r7 = instantiate_node(SyntaxNode,input, i7...index, s7)
          r7.extend(Option2)
        end
        if r7
          r0 = r7
        else
          @index = i0
          r0 = nil
        end
      end

      node_cache[:option][start_index] = r0

      r0
    end

  end

  class RTDLParser < Treetop::Runtime::CompiledParser
    include RTDL
  end

end
