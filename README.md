# MNEDP - Ecuación de Ondas con Método de Líneas

[![Licencia](https://img.shields.io/badge/Licencia-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![MATLAB](https://img.shields.io/badge/MATLAB-R2024a-orange.svg)](https://www.mathworks.com/)

**Autor:** Carlos Yanes Pérez  
**Institución:** Universidad de La Laguna (ULL)  
**Asignatura:** Métodos Numéricos en EDP (MNEDP)  
**Fecha:** 2025  
**Trabajo:** Final de la asignatura

## Descripción General

Este repositorio contiene la implementación en MATLAB de un solver numérico para la ecuación de ondas unidimensional utilizando el método de líneas. El proyecto incluye dos versiones completas del código, cada una con diferentes enfoques y funcionalidades.

### Características principales:
- Discretización espacial mediante diferencias finitas centrales de segundo orden
- Integración temporal utilizando el método Runge-Kutta-Nyström (RKN)
- Análisis de convergencia temporal, espacial y global
- Comparación con series de Fourier y otros problemas (Versión 2)
- Visualización avanzada de resultados

## Planteamiento del Problema

El código resuelve la ecuación de ondas unidimensional:

```
∂²u/∂t² = c² ∂²u/∂x²
```

con condiciones:
- **Dominio:** x ∈ [0, 1], t ∈ [0, 1]
- **Condiciones de frontera:** u(0,t) = u(1,t) = 0 (Dirichlet homogéneas)
- **Condiciones iniciales:**
  - u(x,0) = f(x)
  - ∂u/∂t(x,0) = g(x)

### Problema de prueba (Versión 1)
- c = 1/4
- f(x) = 2sin(4πx)
- g(x) = 0
- **Solución exacta:** u(x,t) = 2sin(4πx)cos(πt)

## Estructura del Proyecto

### Versión 1 (Archivos 1-11)
Implementación básica con solución exacta conocida.

#### Archivos principales:
- `main.m`: Función principal para ejecutar el solver
- `metodoRKN.m`: Implementación del método Runge-Kutta-Nyström
- `crearMatrizDh.m`: Construcción de la matriz de discretización espacial
- `solucionExacta.m`: Solución analítica del problema de prueba
- `derivadaExacta.m`: Derivada temporal de la solución exacta

#### Archivos de análisis:
- `ordenTemporal.m`: Análisis de convergencia temporal
- `ordenEspacial.m`: Análisis de convergencia espacial  
- `ordenGlobal.m`: Análisis de convergencia global

#### Archivos de visualización:
- `graficar.m`: Funciones de graficación y visualización
- `fichero.m`: Exportación de resultados a archivos de texto

### Versión 2 (Archivos 12-19)
Versión mejorada con soporte para problemas generales y comparación con series de Fourier.

#### Nuevas funcionalidades:
- `menu_seleccion.m`: Interfaz para seleccionar parámetros del problema
- `fourier.m`: Implementación de series de Fourier para comparación
- `integracionVariando_m_n.m`: Análisis sistemático variando m y n
- Soporte para diferentes valores de c, f(x) y g(x)

## Método Numérico

### Discretización Espacial
Se utiliza el esquema de diferencias finitas centrales de segundo orden:

```
∂²u/∂x² ≈ (u_{i-1} - 2u_i + u_{i+1})/h²
```

donde h = 1/(m+1) es el paso espacial.

### Integración Temporal
El método Runge-Kutta-Nyström de orden 4 se aplica al sistema:

```
du/dt = v
dv/dt = c² D_h u
```

donde D_h es la matriz de discretización espacial.

### Órdenes de Convergencia Esperados
- **Temporal:** O(τ⁴) debido al método RKN
- **Espacial:** O(h²) debido a las diferencias finitas centrales
- **Global:** O(min(τ⁴, h²)) = O(h²)

## Uso del Código

### Ejecución básica (Versión 1):
```matlab
% Resolver con m=20 puntos espaciales y n=40 puntos temporales
main(20, 40)

% El programa preguntará si desea:
% - Graficar resultados
% - Analizar convergencia (temporal/espacial/global)
```

### Ejecución avanzada (Versión 2):
```matlab
% Ejecutar con menú interactivo
main()

% Opciones disponibles:
% 1. Resolver problema personalizado (con Fourier)
% 2. Resolver problema por defecto
% 3. Análisis sistemático variando m y n
```

### Análisis de convergencia:
```matlab
% Convergencia temporal (m fijo)
ordenTemporal()

% Convergencia espacial (n fijo)
ordenEspacial()

% Convergencia global (m y n proporcionales)
ordenGlobal()
```

## Opciones de Visualización

El programa ofrece múltiples opciones de graficación:

1. **Solución en tiempos específicos:** Comparación numérica vs exacta
2. **Animación temporal:** Evolución de la solución en el tiempo
3. **Gráficos 3D:** Superficies de la solución, derivada y error
4. **Análisis de convergencia:** Gráficos log-log del error vs pasos

## Resultados y Validación

### Verificación de Órdenes
Los análisis de convergencia confirman los órdenes teóricos esperados:
- Convergencia temporal: ≈ 4
- Convergencia espacial: ≈ 2
- Convergencia global: ≈ 2

### Comparación con Series de Fourier
La Versión 2 incluye una implementación de series de Fourier que sirve como solución de referencia para problemas generales sin solución analítica conocida.
Es importante en este caso que las funciones f y g verifiquen las condiciones apropiadas.

## Archivos de Salida

El programa genera:
- **Gráficos:** Múltiples figuras con visualizaciones
- **Resultados numéricos:** Archivos .txt con errores y órdenes de convergencia
- **Tablas de convergencia:** Salida formateada en consola

## Dependencias

- MATLAB R2024a o superior

## Notas de Implementación

- Los códigos están optimizados para claridad y funcionalidad
- Se utiliza indexación de MATLAB (basada en 1)
- Los archivos incluyen documentación detallada en español
- Manejo robusto de condiciones de frontera

## Estructura de Directorios Sugerida

```
proyecto_onda/
├── version1/
│   ├── main.m
│   ├── metodoRKN.m
│   ├── crearMatrizDh.m
│   ├── solucionExacta.m
│   ├── derivadaExacta.m
│   ├── orden*.m
│   ├── graficar.m
│   └── fichero.m
├── version2/
    ├── main.m
    ├── metodoRKN.m
    ├── crearMatrizDh.m
    ├── fourier.m
    ├── menu_seleccion.m
    ├── graficar.m
    └── integracionVariando_m_n.m

```

## Licencia

Este proyecto está licenciado bajo la Licencia MIT - consulte el archivo LICENSE para más detalles.
