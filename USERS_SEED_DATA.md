# 👥 Usuarios de Prueba - Base de Datos Local

## 🔑 Credenciales de Acceso

**Contraseña para todos los usuarios**: `123456`

---

## 👤 USUARIOS NORMALES

### 1. María García López
- **Email**: `usuario@demo.com`
- **Ubicación**: Madrid (Calle Gran Vía, 15, 3º A)
- **Edad**: 28 años
- **Género**: Femenino
- **Altura**: 165 cm | **Peso**: 60 kg
- **Nivel**: Intermedio
- **Bio**: Apasionada del fitness y la vida saludable. Me encanta probar nuevas rutinas de entrenamiento.
- **Coordenadas**: 40.4168, -3.7038

### 2. Juan Martínez Rodríguez  
- **Email**: `juan.martinez@demo.com`
- **Ubicación**: Barcelona (Avenida de la Constitución, 42, 2º B)
- **Edad**: 32 años
- **Género**: Masculino
- **Altura**: 178 cm | **Peso**: 75 kg
- **Nivel**: Principiante
- **Bio**: Comenzando mi viaje hacia una vida más saludable. Busco motivación y constancia.
- **Coordenadas**: 41.3851, 2.1734

### 3. Ana López Fernández
- **Email**: `ana.lopez@demo.com`
- **Ubicación**: Valencia (Plaza Mayor, 8, 1º C)
- **Edad**: 25 años
- **Género**: Femenino
- **Altura**: 160 cm | **Peso**: 55 kg
- **Nivel**: Avanzado
- **Bio**: Atleta amateur. Compito en carreras de 10K y medias maratones. Siempre buscando mejorar mis tiempos.
- **Coordenadas**: 39.4699, -0.3763

### 4. Carlos Ruiz Sánchez
- **Email**: `carlos.ruiz@demo.com`
- **Ubicación**: Sevilla (Calle del Prado, 23, 4º D)
- **Edad**: 35 años
- **Género**: Masculino
- **Altura**: 182 cm | **Peso**: 80 kg
- **Nivel**: Intermedio
- **Bio**: Padre de familia que busca mantenerse en forma. Me gusta el entrenamiento funcional.
- **Coordenadas**: 37.3886, -5.9823

---

## 💪 ENTRENADORES

### 1. Carlos Mendoza Silva
- **Email**: `entrenador@demo.com`
- **Ubicación**: Madrid (Calle Serrano, 95, 1º A)
- **Edad**: 30 años
- **Género**: Masculino
- **Altura**: 185 cm | **Peso**: 78 kg
- **Especialidades**: Entrenamiento funcional, Pérdida de peso, Fuerza
- **Tarifa**: €45/hora
- **Experiencia**: 8 años
- **Certificaciones**: ACSM-CPT, NASM-PES, Especialista en Nutrición Deportiva
- **Bio**: Entrenador personal certificado con 8 años de experiencia. Especializado en transformaciones corporales y entrenamiento funcional.
- **Coordenadas**: 40.4268, -3.6938

### 2. Sofía Herrera Morales
- **Email**: `sofia.trainer@demo.com`
- **Ubicación**: Barcelona (Passeig de Gràcia, 112, 3º B)
- **Edad**: 27 años
- **Género**: Femenino
- **Altura**: 168 cm | **Peso**: 58 kg
- **Especialidades**: Yoga, Pilates, Rehabilitación, Entrenamiento prenatal
- **Tarifa**: €40/hora
- **Experiencia**: 5 años
- **Certificaciones**: RYT-500 Yoga Alliance, Pilates Instructor, Fisioterapeuta
- **Bio**: Instructora de yoga y pilates. Me especializo en rehabilitación y entrenamiento para mujeres embarazadas.
- **Coordenadas**: 41.3951, 2.1634

### 3. Miguel Torres Jiménez
- **Email**: `miguel.crossfit@demo.com`
- **Ubicación**: Valencia (Calle Colón, 45, 2º A)
- **Edad**: 33 años
- **Género**: Masculino
- **Altura**: 175 cm | **Peso**: 85 kg
- **Especialidades**: CrossFit, Powerlifting, Entrenamiento de fuerza
- **Tarifa**: €50/hora
- **Experiencia**: 10 años
- **Certificaciones**: CrossFit Level 2, USA Powerlifting Coach, NSCA-CSCS
- **Bio**: Coach de CrossFit y powerlifting. Ex-atleta competitivo. Me enfoco en mejorar la fuerza y el rendimiento atlético.
- **Coordenadas**: 39.4799, -0.3663

### 4. Laura Vega Castillo
- **Email**: `laura.nutrition@demo.com`
- **Ubicación**: Sevilla (Avenida de la Palmera, 78, 5º C)
- **Edad**: 29 años
- **Género**: Femenino
- **Altura**: 162 cm | **Peso**: 54 kg
- **Especialidades**: Nutrición deportiva, Pérdida de peso, Planes alimentarios
- **Tarifa**: €35/hora
- **Experiencia**: 6 años
- **Certificaciones**: Dietista-Nutricionista, Especialista en Nutrición Deportiva
- **Bio**: Nutricionista deportiva especializada en planes de alimentación personalizados y pérdida de peso saludable.
- **Coordenadas**: 37.3786, -5.9723

---

## 🗄️ Estructura de la Base de Datos

### Campos de Usuario:
- **Básicos**: id, email, password, firstName, lastName, phone
- **Ubicación**: address, city, country, latitude, longitude
- **Perfil**: profileImageUrl, bio, age, gender
- **Físicos**: height (cm), weight (kg), fitnessLevel
- **Entrenadores**: specializations, hourlyRate, certifications, yearsExperience
- **Sistema**: role, isActive, createdAt, updatedAt

### Niveles de Fitness:
- `beginner` - Principiante
- `intermediate` - Intermedio  
- `advanced` - Avanzado

### Roles:
- `user` - Usuario normal
- `trainer` - Entrenador

---

## 🚀 Cómo Usar

1. **Registro**: Los datos se insertan automáticamente al crear la base de datos
2. **Login**: Usa cualquier email de la lista con contraseña `123456`
3. **Navegación**: Los usuarios van al dashboard normal, los entrenadores al dashboard de entrenador
4. **Testing**: Todos los usuarios tienen datos completos para pruebas

---

## 📍 Ubicaciones en el Mapa

Los usuarios están distribuidos en las principales ciudades españolas:
- **Madrid**: María García, Carlos Mendoza
- **Barcelona**: Juan Martínez, Sofía Herrera  
- **Valencia**: Ana López, Miguel Torres
- **Sevilla**: Carlos Ruiz, Laura Vega

Cada usuario tiene coordenadas reales para testing de funcionalidades de geolocalización. 