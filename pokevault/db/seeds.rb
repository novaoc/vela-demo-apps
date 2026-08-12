cards = [
  ["Charizard ex", "Obsidian Flames", "125", "Ultra Rare", 4500, "🔥"],
  ["Pikachu VMAX", "Vivid Voltage", "044", "Secret Rare", 8900, "⚡"],
  ["Mewtwo GX", "Shining Legends", "39", "Ultra Rare", 3200, "🧠"],
  ["Umbreon VMAX", "Evolving Skies", "215", "Alternate Art", 52000, "🌙"],
  ["Gengar VMAX", "Fusion Strike", "271", "Alternate Art", 18500, "👻"],
  ["Blastoise", "Base Set", "2", "Rare Holo", 12000, "💧"],
  ["Venusaur ex", "151", "198", "Special Illustration", 6700, "🌿"],
  ["Rayquaza VMAX", "Evolving Skies", "218", "Alternate Art", 24000, "🐉"],
  ["Snorlax", "Jungle", "11", "Rare Holo", 2800, "😴"],
  ["Mew ex", "151", "151", "Ultra Rare", 4100, "✨"],
  ["Gardevoir ex", "Scarlet and Violet", "86", "Double Rare", 1900, "💎"],
  ["Lugia V", "Silver Tempest", "186", "Alternate Art", 9800, "🕊️"]
]
cards.each do |name, set_name, number, rarity, cents, emoji|
  PokemonCard.find_or_create_by!(set_name: set_name, number: number) do |c|
    c.name = name
    c.rarity = rarity
    c.market_price_cents = cents
    c.image_emoji = emoji
  end
end
puts "Seeded #{PokemonCard.count} Pokemon cards"
