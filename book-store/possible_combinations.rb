require 'set'

module PossibleCombinations
  module_function

  def for(combinations, permutations)
    uniqueness merge(combinations, permutations)
  end

  def merge(combinations, permutations)
    combinations.flat_map do |bundles|
      permutations.map do |permutation|
        bundles.dup.zip(permutation).map do |new_bundle|
          new_bundle.flatten.compact
        end
      end
    end
  end

  def uniqueness(combinations)
    combinations.each_with_object(Set.new) do |combination, object|
      object << combination.sort
    end.to_a
  end
end