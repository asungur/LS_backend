# ROT 13 ENCRYPTION
ENCRYPTED_PIONEERS = ['Nqn Ybirynpr',
'Tenpr Ubccre',
'Nqryr Tbyqfgvar',
'Nyna Ghevat',
'Puneyrf Onoontr',
'Noqhyynu Zhunzznq ova Zhfn ny-Xujnevmzv',
'Wbua Ngnanfbss',
'Ybvf Unvog',
'Pynhqr Funaaba',
'Fgrir Wbof',
'Ovyy Tngrf',
'Gvz Orearef-Yrr',
'Fgrir Jbmavnx',
'Xbaenq Mhfr',
'Fve Nagbal Ubner',
'Zneiva Zvafxl',
'Lhxvuveb Zngfhzbgb',
'Unllvz Fybavzfxv',
'Tregehqr Oynapu' ].freeze

def decrypt_rot13(string)
  words = string.split(' ')
  return_words = []
  words.each do |word|
    return_word = ''
    word.split('').each do |char|
      if ('a'..'m').include?(char) || ('A'..'M').include?(char)
        return_word << (char.ord + 13).chr
      elsif ('n'..'z').include?(char) || ('N'..'Z').include?(char)
        return_word << (char.ord - 13).chr
      else
        return_word << char
      end
    end
    return_words << return_word
  end
  return_words.join(' ')
end

ENCRYPTED_PIONEERS.each do |pioneer|
  p decrypt_rot13(pioneer)
end

