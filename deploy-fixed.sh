#!/bin/bash

# 🚀 Script de Deployment para FortiSASE Health Check en GitHub Pages
# Versión corregida - Automatiza la creación del repositorio y configuración de GitHub Pages

set -e

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Función para logs con color
log() {
    echo -e "${BLUE}[$(date +'%Y-%m-%d %H:%M:%S')]${NC} $1"
}

success() {
    echo -e "${GREEN}✅${NC} $1"
}

warning() {
    echo -e "${YELLOW}⚠️${NC} $1"
}

error() {
    echo -e "${RED}❌${NC} $1"
}

echo "🚀 Configurando FortiSASE Health Check para GitHub Pages..."
echo ""

# Verificar si Git está instalado
if ! command -v git &> /dev/null; then
    error "Git no está instalado. Por favor instala Git primero."
    exit 1
fi

# Verificar si GitHub CLI está instalado
MANUAL_REPO=false
if ! command -v gh &> /dev/null; then
    warning "GitHub CLI no está instalado. Necesitarás crear el repositorio manualmente."
    echo "Puedes instalar GitHub CLI desde: https://cli.github.com/"
    MANUAL_REPO=true
else
    success "GitHub CLI detectado"
fi

# Solicitar información del usuario
echo ""
log "Configuración inicial..."
read -p "Nombre de usuario de GitHub: " GITHUB_USERNAME
read -p "Nombre del repositorio (por defecto: fortisase-healthcheck): " REPO_NAME
REPO_NAME=${REPO_NAME:-fortisase-healthcheck}

read -p "¿Es un repositorio público? (y/N): " IS_PUBLIC
if [[ $IS_PUBLIC =~ ^[Yy]$ ]]; then
    REPO_VISIBILITY="public"
else
    REPO_VISIBILITY="private"
fi

# Directorio del proyecto
PROJECT_DIR="$REPO_NAME"

# Crear directorio del proyecto si no existe
if [ ! -d "$PROJECT_DIR" ]; then
    log "Creando directorio del proyecto: $PROJECT_DIR"
    mkdir -p "$PROJECT_DIR"
fi

cd "$PROJECT_DIR"

# Inicializar Git si no está inicializado
if [ ! -d ".git" ]; then
    log "Inicializando repositorio Git..."
    git init
    git branch -M main
fi

# Crear estructura de directorios
log "Creando estructura de directorios..."
mkdir -p .github/ISSUE_TEMPLATE
mkdir -p assets

# Crear archivo .gitignore
log "Creando .gitignore..."
cat > .gitignore << 'GITIGNORE_EOF'
# OS generated files
.DS_Store
.DS_Store?
._*
.Spotlight-V100
.Trashes
ehthumbs.db
Thumbs.db

# IDE files
.vscode/
.idea/
*.swp
*.swo
*~

# Node modules (if we add build process later)
node_modules/
npm-debug.log*
yarn-debug.log*
yarn-error.log*

# Build outputs
dist/
build/

# Temporary files
*.tmp
*.temp

# Log files
*.log
GITIGNORE_EOF

# Crear el index.html básico
log "Creando index.html básico..."
cat > index.html << 'HTML_EOF'
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FortiSASE Health Check Dashboard</title>
    <meta name="description" content="Herramienta de análisis y optimización de aprovechamiento de licencias FortiSASE">
    <meta name="keywords" content="Fortinet, FortiSASE, SASE, Security, Dashboard, License Management">
    
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    
    <style>
        .loading-spinner {
            border: 4px solid #f3f3f3;
            border-top: 4px solid #dc2626;
            border-radius: 50%;
            width: 40px;
            height: 40px;
            animation: spin 1s linear infinite;
            margin: 0 auto;
        }
        
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        
        .hero-gradient {
            background: linear-gradient(135deg, #dc2626 0%, #991b1b 100%);
        }
    </style>
</head>
<body class="bg-gray-50">
    <!-- Header -->
    <div class="hero-gradient text-white py-12">
        <div class="max-w-4xl mx-auto px-6 text-center">
            <h1 class="text-4xl font-bold mb-4">🔍 FortiSASE Health Check Dashboard</h1>
            <p class="text-xl mb-6 text-red-100">Herramienta de análisis y optimización de aprovechamiento de licencias FortiSASE</p>
            <div class="inline-flex items-center bg-white bg-opacity-20 rounded-lg px-6 py-3">
                <div class="loading-spinner mr-4" style="width: 24px; height: 24px;"></div>
                <span class="text-lg">Próximamente: Dashboard Completo</span>
            </div>
        </div>
    </div>

    <!-- Content -->
    <div class="max-w-6xl mx-auto px-6 py-12">
        <div class="grid md:grid-cols-2 gap-8 mb-12">
            <!-- Features -->
            <div class="bg-white rounded-lg shadow-md p-8">
                <h2 class="text-2xl font-bold text-gray-900 mb-6">✨ Características Principales</h2>
                <ul class="space-y-4">
                    <li class="flex items-start">
                        <span class="text-green-500 mr-3">📊</span>
                        <div>
                            <strong>Dashboard Interactivo</strong><br>
                            <span class="text-gray-600">Visualización en tiempo real del estado de todas las funcionalidades FortiSASE</span>
                        </div>
                    </li>
                    <li class="flex items-start">
                        <span class="text-green-500 mr-3">💰</span>
                        <div>
                            <strong>Análisis Financiero</strong><br>
                            <span class="text-gray-600">Cálculo de ROI, costos desperdiciados y oportunidades de ahorro</span>
                        </div>
                    </li>
                    <li class="flex items-start">
                        <span class="text-green-500 mr-3">📈</span>
                        <div>
                            <strong>Métricas de Aprovechamiento</strong><br>
                            <span class="text-gray-600">Seguimiento detallado por funcionalidad con benchmarks industriales</span>
                        </div>
                    </li>
                    <li class="flex items-start">
                        <span class="text-green-500 mr-3">📋</span>
                        <div>
                            <strong>Reportes Ejecutivos</strong><br>
                            <span class="text-gray-600">Generación automática de resúmenes para C-Level</span>
                        </div>
                    </li>
                </ul>
            </div>

            <!-- Status -->
            <div class="bg-white rounded-lg shadow-md p-8">
                <h2 class="text-2xl font-bold text-gray-900 mb-6">🚀 Estado del Proyecto</h2>
                <div class="space-y-4">
                    <div class="flex items-center justify-between p-4 bg-blue-50 rounded-lg">
                        <span class="font-medium">Infraestructura</span>
                        <span class="bg-green-100 text-green-800 px-3 py-1 rounded-full text-sm">✅ Completa</span>
                    </div>
                    <div class="flex items-center justify-between p-4 bg-blue-50 rounded-lg">
                        <span class="font-medium">Dashboard Base</span>
                        <span class="bg-yellow-100 text-yellow-800 px-3 py-1 rounded-full text-sm">🔄 En Progreso</span>
                    </div>
                    <div class="flex items-center justify-between p-4 bg-blue-50 rounded-lg">
                        <span class="font-medium">Componentes React</span>
                        <span class="bg-yellow-100 text-yellow-800 px-3 py-1 rounded-full text-sm">🔄 Integrando</span>
                    </div>
                    <div class="flex items-center justify-between p-4 bg-blue-50 rounded-lg">
                        <span class="font-medium">GitHub Pages</span>
                        <span class="bg-green-100 text-green-800 px-3 py-1 rounded-full text-sm">✅ Activo</span>
                    </div>
                </div>
            </div>
        </div>

        <!-- Instructions -->
        <div class="bg-white rounded-lg shadow-md p-8">
            <h2 class="text-2xl font-bold text-gray-900 mb-6">📝 Próximos Pasos</h2>
            <div class="grid md:grid-cols-3 gap-6">
                <div class="text-center">
                    <div class="w-12 h-12 bg-red-100 text-red-600 rounded-full flex items-center justify-center mx-auto mb-4 text-xl font-bold">1</div>
                    <h3 class="font-semibold mb-2">Código React</h3>
                    <p class="text-gray-600 text-sm">Integrar el componente React completo del dashboard</p>
                </div>
                <div class="text-center">
                    <div class="w-12 h-12 bg-red-100 text-red-600 rounded-full flex items-center justify-center mx-auto mb-4 text-xl font-bold">2</div>
                    <h3 class="font-semibold mb-2">Screenshot</h3>
                    <p class="text-gray-600 text-sm">Agregar preview image para el README</p>
                </div>
                <div class="text-center">
                    <div class="w-12 h-12 bg-red-100 text-red-600 rounded-full flex items-center justify-center mx-auto mb-4 text-xl font-bold">3</div>
                    <h3 class="font-semibold mb-2">Launch</h3>
                    <p class="text-gray-600 text-sm">¡Dashboard completo listo para la comunidad!</p>
                </div>
            </div>
        </div>

        <!-- Footer -->
        <div class="text-center mt-12 text-gray-600">
            <p class="mb-4">Made with ❤️ for the Cybersecurity Community</p>
            <p class="text-sm">Esta herramienta es independiente y no está afiliada oficialmente con Fortinet Inc.</p>
        </div>
    </div>
</body>
</html>
HTML_EOF

warning "IMPORTANTE: Después del deployment, necesitas reemplazar index.html con el código completo del React component"

# Crear README.md dinámico
log "Creando README.md..."
cat > README.md << README_EOF
# 🔍 FortiSASE Health Check Dashboard

> **Herramienta de análisis y optimización de aprovechamiento de licencias FortiSASE**

[![Live Demo](https://img.shields.io/badge/Live%20Demo-GitHub%20Pages-brightgreen)](https://${GITHUB_USERNAME}.github.io/${REPO_NAME}/)
[![Version](https://img.shields.io/badge/Version-1.0.0--beta-orange)](https://github.com/${GITHUB_USERNAME}/${REPO_NAME}/releases)
[![License](https://img.shields.io/badge/License-MIT-blue)](LICENSE)
[![Feedback](https://img.shields.io/badge/Feedback-Welcome-yellow)](https://github.com/${GITHUB_USERNAME}/${REPO_NAME}/issues/new?template=feedback.md)

## 🎯 ¿Qué es FortiSASE Health Check?

Una herramienta **interactiva y gratuita** que permite a organizaciones analizar el aprovechamiento de sus licencias FortiSASE, identificar oportunidades de optimización y generar reportes ejecutivos para la toma de decisiones estratégicas.

## 🚀 Demo en Vivo

**[👉 Prueba la herramienta aquí](https://${GITHUB_USERNAME}.github.io/${REPO_NAME}/)**

![Dashboard Preview](assets/preview.png)

## ✨ Características Principales

- 📊 **Dashboard Interactivo**: Visualización en tiempo real del estado de todas las funcionalidades FortiSASE
- 💰 **Análisis Financiero**: Cálculo de ROI, costos desperdiciados y oportunidades de ahorro
- 📈 **Métricas de Aprovechamiento**: Seguimiento detallado por funcionalidad con benchmarks industriales
- 📋 **Reportes Ejecutivos**: Generación automática de resúmenes para C-Level
- 💾 **Gestión de Configuración**: Exportación e importación de configuraciones para seguimiento histórico

## 🤝 Contribuir y Feedback

### 🐛 Reportar Issues
¿Encontraste un problema? [Crea un issue](https://github.com/${GITHUB_USERNAME}/${REPO_NAME}/issues/new?template=bug_report.md)

### 💡 Sugerir Mejoras
¿Tienes ideas para mejorar la herramienta? [Comparte tu feedback](https://github.com/${GITHUB_USERNAME}/${REPO_NAME}/issues/new?template=feedback.md)

## 📄 Licencia

Este proyecto está licenciado bajo la Licencia MIT - ver el archivo [LICENSE](LICENSE) para más detalles.

---

**⭐ Si esta herramienta te resulta útil, considera darle una estrella al repositorio**

Made with ❤️ for the Cybersecurity Community
README_EOF

# Crear templates y otros archivos...
log "Creando templates de issues..."

cat > .github/ISSUE_TEMPLATE/feedback.md << 'FEEDBACK_EOF'
---
name: 💡 Feedback & Sugerencias
about: Comparte tu experiencia, sugerencias o casos de uso
title: '[FEEDBACK] '
labels: ['feedback', 'enhancement']
assignees: ''
---

## 🎯 Tipo de Feedback
- [ ] Sugerencia de nueva funcionalidad
- [ ] Mejora de funcionalidad existente
- [ ] Caso de uso específico
- [ ] Experiencia de usuario

## 📝 Descripción


## 💡 Valor Esperado


## 🔥 Prioridad
- [ ] Baja
- [ ] Media  
- [ ] Alta
FEEDBACK_EOF

cat > .github/ISSUE_TEMPLATE/bug_report.md << 'BUG_EOF'
---
name: 🐛 Bug Report
about: Reporta un problema o error en la aplicación
title: '[BUG] '
labels: ['bug', 'needs-triage']
assignees: ''
---

## 🐛 Resumen del Bug


## 🔄 Pasos para Reproducir
1. 
2. 
3. 

## ✅ Comportamiento Esperado


## ❌ Comportamiento Actual


## 💻 Información del Sistema
**Navegador:** 
**OS:** 
**Resolución:** 
BUG_EOF

# Crear LICENSE
cat > LICENSE << LICENSE_EOF
MIT License

Copyright (c) $(date +%Y) ${GITHUB_USERNAME}

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
LICENSE_EOF

# Git operations
git add .
git commit -m "🎉 Initial commit: FortiSASE Health Check Dashboard"

# GitHub operations
if [ "$MANUAL_REPO" = false ]; then
    log "Autenticando con GitHub..."
    if ! gh auth status &> /dev/null; then
        gh auth login
    fi

    log "Creando repositorio en GitHub..."
    gh repo create "$REPO_NAME" --$REPO_VISIBILITY --source=. --remote=origin --push

    success "Repositorio creado exitosamente!"
    
    log "Habilitando GitHub Pages..."
    sleep 5
    
    if gh api repos/$GITHUB_USERNAME/$REPO_NAME/pages -X POST -f source.branch=main -f source.path=/ &> /dev/null; then
        success "GitHub Pages habilitado!"
    else
        warning "Configura GitHub Pages manualmente"
    fi
fi

success "🎉 ¡Configuración completada!"
echo ""
echo "🌐 URL del repositorio: https://github.com/$GITHUB_USERNAME/$REPO_NAME"
echo "🚀 URL de GitHub Pages: https://$GITHUB_USERNAME.github.io/$REPO_NAME/"
echo ""
echo "📝 Próximos pasos:"
echo "1. Edita index.html con el código React completo"
echo "2. Agrega screenshot en assets/preview.png"
echo "3. Commit y push los cambios"
