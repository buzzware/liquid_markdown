module LiquidMarkdown
  class Keys
    # convert keys from symbol to string
    # Example:
    # {a: {b: 'c'}} => {'a' => {'b' => 'c'}}
    def self.deep_stringify_keys(hash)
      s2s = -> (h) do
        Hash === h ?
            Hash[
                h.map do |k, v|
                  [k.respond_to?(:to_sym) ? k.to_s : k, s2s[v]]
                end
            ] : h
      end
      s2s[hash]
    end
  end
end