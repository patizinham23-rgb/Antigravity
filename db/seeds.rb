# Categorias
ourivesaria = Category.create!(name: "Ourivesaria", slug: "ourivesaria", description: "Cursos de ourivesaria artesanal e técnicas de joalheria.")
design = Category.create!(name: "Design", slug: "design", description: "Design de joias e criação de peças exclusivas.")
gemologia = Category.create!(name: "Gemologia", slug: "gemologia", description: "Estudo e identificação de pedras preciosas.")
ferramentas = Category.create!(name: "Ferramentas", slug: "ferramentas", description: "Ferramentas e equipamentos para joalheria.")

# Admin
admin = User.create!(
  name: "Administrador",
  email: "admin@antigravity.com",
  password: "123456",
  role: :admin
)

# Instrutores
instructor1 = User.create!(
  name: "Carla Mendes",
  email: "carla@antigravity.com",
  password: "123456",
  role: :instructor,
  bio: "Mestre joalheira com 20 anos de experiência em ourivesaria fina. Especialista em design de joias com diamantes."
)

instructor2 = User.create!(
  name: "Ricardo Oliveira",
  email: "ricardo@antigravity.com",
  password: "123456",
  role: :instructor,
  bio: "Gemólogo certificado pelo GIA. Especialista em pedras preciosas e certificação de diamantes."
)

# Cursos
curso1 = Course.create!(
  title: "Fundamentos da Ourivesaria",
  description: "Aprenda as técnicas fundamentais da ourivesaria desde o início. Este curso cobre desde a seleção de metais até as técnicas de solda e acabamento. Ideal para iniciantes que desejam entrar no mundo da joalheria artesanal.",
  short_description: "Domine as técnicas básicas da ourivesaria artesanal.",
  price: 2970,
  instructor: instructor1,
  category: ourivesaria,
  level: :beginner,
  status: :published,
  duration: 40
)

curso2 = Course.create!(
  title: "Design de Joias com Diamantes",
  description: "Curso completo sobre design e criação de joias com diamantes. Aborda desde a classificação dos 4Cs até técnicas avançadas de cravação e engaste.",
  short_description: "Crie joias deslumbrantes com diamantes.",
  price: 4900,
  instructor: instructor1,
  category: design,
  level: :intermediate,
  status: :published,
  duration: 60
)

curso3 = Course.create!(
  title: "Gemologia para Joalheiros",
  description: "Identificação, classificação e certificação de gemas. Aprenda a usar equipamentos de gemologia e a avaliar pedras preciosas com precisão profissional.",
  short_description: "Identifique e avalie pedras preciosas como um profissional.",
  price: 3500,
  instructor: instructor2,
  category: gemologia,
  level: :advanced,
  status: :published,
  duration: 50
)

# Aulas do Curso 1
[
  { title: "Introdução à Ourivesaria", content: "Bem-vindo ao curso de Fundamentos da Ourivesaria. Nesta aula, vamos explorar a história da ourivesaria, as ferramentas básicas e os materiais que utilizaremos ao longo do curso.", duration: 15, position: 0, free_preview: true },
  { title: "Metais Preciosos", content: "Vamos estudar as propriedades do ouro, prata, platina e paládio. Entenda as ligas metálicas, quilates e como escolher o metal ideal para cada projeto.", duration: 25, position: 1, free_preview: false },
  { title: "Ferramentas Essenciais", content: "Conheça as ferramentas fundamentais: limas, serras, pinças, maçaricos e martelos. Aprenda a usar e manter cada ferramenta corretamente.", duration: 20, position: 2, free_preview: false },
  { title: "Técnicas de Solda", content: "Técnicas de solda para ourivesaria. Solda dura, média e fácil. Preparação das peças, fluxo e acabamento pós-solda.", duration: 35, position: 3, free_preview: false },
  { title: "Acabamento e Polimento", content: "Técnicas profissionais de acabamento. Lixamento, polimento com pasta diamantada, jateamento e banho de ouro/rodio.", duration: 30, position: 4, free_preview: false },
  { title: "Projeto Final: Anel Simples", content: "Aplicação prática de tudo que aprendemos. Criação passo a passo de um anel simples em prata 950.", duration: 45, position: 5, free_preview: false },
].each do |lesson_data|
  curso1.lessons.create!(lesson_data)
end

# Aulas do Curso 2
[
  { title: "Os 4Cs dos Diamantes", content: "Aprenda sobre Cut, Color, Clarity e Carat. Como cada fator influencia o valor e a beleza de um diamante.", duration: 30, position: 0, free_preview: true },
  { title: "Tipos de Cravação", content: "Cravação em garras, em canal, pavê, bezel e tensão. Vantagens e aplicações de cada técnica.", duration: 25, position: 1, free_preview: false },
  { title: "Design de Anéis de Noivado", content: "Do esboço ao modelo final. Design de anéis de noivado clássicos e contemporâneos.", duration: 40, position: 2, free_preview: false },
  { title: "Técnicas de Engaste", content: "Engaste de diamantes redondos e fancy. Preparação do alvéolo e segurança da pedra.", duration: 35, position: 3, free_preview: false },
  { title: "Certificação e Avaliação", content: "Como ler certificados GIA, HRD e IGI. Avaliação comercial e seguros.", duration: 20, position: 4, free_preview: false },
].each do |lesson_data|
  curso2.lessons.create!(lesson_data)
end

# Aulas do Curso 3
[
  { title: "Introdução à Gemologia", content: "O que é gemologia, história e importância. Tipos de gemas e suas classificações.", duration: 20, position: 0, free_preview: true },
  { title: "Equipamentos Gemológicos", content: "Refratômetro, polariscópio, dicroscópio, balança hidrostática e microscópio. Uso e interpretação de resultados.", duration: 35, position: 1, free_preview: false },
  { title: "Identificação de Gemas", content: "Técnicas de identificação: índice de refração, densidade, dureza, fluorescência e inclusões.", duration: 40, position: 2, free_preview: false },
  { title: "Gemas Sintéticas e Tratamentos", content: "Como identificar gemas sintéticas e tratamentos comuns (aquecimento, irradiação, preenchimento).", duration: 30, position: 3, free_preview: false },
  { title: "Avaliação Comercial", content: "Tabelas de preços, fatores de valorização e como emitir laudos de avaliação.", duration: 25, position: 4, free_preview: false },
].each do |lesson_data|
  curso3.lessons.create!(lesson_data)
end

# Alunos
aluno1 = User.create!(name: "Maria Silva", email: "maria@teste.com", password: "123456", role: :student)
aluno2 = User.create!(name: "João Santos", email: "joao@teste.com", password: "123456", role: :student)
aluno3 = User.create!(name: "Ana Costa", email: "ana@teste.com", password: "123456", role: :student)

# Matrículas
enroll1 = Enrollment.create!(user: aluno1, course: curso1, status: :active, progress: 35.0)
enroll2 = Enrollment.create!(user: aluno1, course: curso2, status: :active, progress: 10.0)
enroll3 = Enrollment.create!(user: aluno2, course: curso1, status: :active, progress: 70.0)
enroll4 = Enrollment.create!(user: aluno3, course: curso3, status: :active, progress: 0.0)

puts "✅ Seed concluído!"
puts "  Admin: admin@antigravity.com / 123456"
puts "  Instrutor: carla@antigravity.com / 123456"
puts "  Aluno: maria@teste.com / 123456"
