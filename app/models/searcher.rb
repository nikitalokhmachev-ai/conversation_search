class Searcher
  def initialize(collection)
    @collection = collection
  end

  def jaccard_similarity(instance_a, instance_b)
    # instanceA and instanceB are both arrays of tokens
    set_a = instance_a.to_set
    set_b = instance_b.to_set
    intersection = set_a.intersection(set_b)
    union = set_a.union(set_b)
    intersection.size.to_f / union.size.to_f
  end

  def search(instance, top_n: 3)
    jaccard_distances = []
    @collection.each do |item|
      jaccard_distances << jaccard_similarity(instance, item)
    end
    # argsort the jaccard_distances array
    jaccard_distances.each_with_index.sort.map(&:last).reverse[0..top_n - 1]
    # .reverse[0..top_n - 1]
  end
end
