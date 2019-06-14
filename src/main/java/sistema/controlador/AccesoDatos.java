// Written by Ismael Heredia in the year 2016
package sistema.controlador;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import sistema.entity.Productos;
import sistema.entity.Proveedores;
import sistema.entity.Usuarios;
import sistema.util.HibernateUtil;
import java.util.ArrayList;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.ArrayList;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import sistema.util.HibernateUtil;

public class AccesoDatos {

    public Integer ejecutarConsulta(String query) {
        int cantidad = 0;
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.beginTransaction();
        Query q = session.createQuery(query);
        ArrayList lista = (ArrayList) q.list();
        return lista.size();
    }

    public boolean ingreso_usuario(String username, String password) {
        boolean respuesta = false;
        try {
            int cantidad = ejecutarConsulta("from Usuarios where usuario='" + username + "' and clave='" + password + "'");
            if (cantidad >= 1) {
                respuesta = true;
            } else {
                respuesta = false;
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return respuesta;
    }
    
    public boolean es_admin(String username) {
        boolean respuesta = false;
        try {
            String query = "from Usuarios where usuario='" + username + "'";
            Session session = HibernateUtil.getSessionFactory().openSession();
            session.beginTransaction();
            Query q = session.createQuery(query);
            ArrayList lista = (ArrayList) q.list();
            for (Object o : lista) {
                Usuarios usuario = (Usuarios) o;
                int tipo = usuario.getTipo();
                if (tipo == 1) {
                    respuesta = true;
                } else {
                    respuesta = false;
                }
            }
        } catch (Exception e) {
            //
        }
        return respuesta;
    }
    
    public int get_id_by_username(String username) {
        int id_usuario = 0;
        try {
            String query = "from Usuarios where usuario='" + username + "'";
            Session session = HibernateUtil.getSessionFactory().openSession();
            session.beginTransaction();
            Query q = session.createQuery(query);
            ArrayList lista = (ArrayList) q.list();
            for (Object o : lista) {
                Usuarios usuario = (Usuarios) o;
                id_usuario = usuario.getIdUsuario();
            }
        } catch (Exception e) {
            //
        }
        return id_usuario;
    }
    
    public Boolean agregarProveedor(String nombre_proveedor, String direccion, int telefono, String fecha_registro) {
        boolean response = false;
        try {
            Session session = HibernateUtil.getSessionFactory().openSession();
            session.beginTransaction();
            Proveedores proveedor = new Proveedores();
            proveedor.setNombreEmpresa(nombre_proveedor);
            proveedor.setDireccion(direccion);
            proveedor.setTelefono(telefono);
            proveedor.setFechaRegistroProveedor(fecha_registro);
            session.save(proveedor);
            session.getTransaction().commit();
            response = true;
        } catch (HibernateException he) {
            response = false;
        }
        return response;
    }
    
    public Boolean editarProveedor(int id_proveedor, String nombre_proveedor, String direccion, int telefono, String fecha_registro) {
        boolean response = false;
        try {
            Session session = HibernateUtil.getSessionFactory().openSession();
            session.beginTransaction();
            Proveedores proveedor = (Proveedores) session.get(Proveedores.class, id_proveedor);
            proveedor.setNombreEmpresa(nombre_proveedor);
            proveedor.setDireccion(direccion);
            proveedor.setTelefono(telefono);
            if (!"".equals(fecha_registro)) {
                proveedor.setFechaRegistroProveedor(fecha_registro);
            }
            session.update(proveedor);
            session.getTransaction().commit();
            response = true;
        } catch (HibernateException he) {
            response = false;
        }
        return response;
    }
    
    public Boolean borrarProveedor(int id_proveedor) {
        boolean response = false;
        try {
            Session session = HibernateUtil.getSessionFactory().openSession();
            session.beginTransaction();
            Proveedores proveedor = new Proveedores();
            proveedor.setIdProveedor(id_proveedor);
            session.delete(proveedor);
            session.getTransaction().commit();
            response = true;
        } catch (HibernateException he) {
            response = false;
        }
        return response;
    }
    
    public Boolean agregarProducto(String nombre_producto, String descripcion, int precio, int id_proveedor, String fecha_registro) {
        boolean response = false;
        try {
            Session session = HibernateUtil.getSessionFactory().openSession();
            session.beginTransaction();
            Productos producto = new Productos();
            producto.setNombreProducto(nombre_producto);
            producto.setDescripcion(descripcion);
            producto.setPrecio(precio);
            Proveedores proveedor = (Proveedores) session.get(Proveedores.class, id_proveedor);
            producto.setProveedores(proveedor);
            producto.setFechaRegistro(fecha_registro);
            session.save(producto);
            session.getTransaction().commit();
            response = true;
        } catch (HibernateException he) {
            response = false;
        }
        return response;
    }
    
    public Boolean editarProducto(int id_producto, String nombre_producto, String descripcion, int precio, int id_proveedor, String fecha_registro) {
        boolean response = false;
        try {
            Session session = HibernateUtil.getSessionFactory().openSession();
            session.beginTransaction();
            Productos producto = (Productos) session.get(Productos.class, id_producto);
            producto.setNombreProducto(nombre_producto);
            producto.setDescripcion(descripcion);
            producto.setPrecio(precio);
            Proveedores proveedor = (Proveedores) session.get(Proveedores.class, id_proveedor);
            producto.setProveedores(proveedor);
            if (!"".equals(fecha_registro)) {
                producto.setFechaRegistro(fecha_registro);
            }
            session.update(producto);
            session.getTransaction().commit();
            response = true;
        } catch (HibernateException he) {
            response = false;
        }
        return response;
    }
    
    public Boolean borrarProducto(int id_producto) {
        boolean response = false;
        try {
            Session session = HibernateUtil.getSessionFactory().openSession();
            session.beginTransaction();
            Productos producto = new Productos();
            producto.setIdProducto(id_producto);
            session.delete(producto);
            session.getTransaction().commit();
            response = true;
        } catch (HibernateException he) {
            response = false;
        }
        return response;
    }
    
    public Boolean agregarUsuario(String nombre_usuario, String clave, int tipo, String fecha_registro) {
        boolean response = false;
        try {
            Session session = HibernateUtil.getSessionFactory().openSession();
            session.beginTransaction();
            Usuarios usuario = new Usuarios();
            usuario.setUsuario(nombre_usuario);
            usuario.setClave(clave);
            usuario.setTipo(tipo);
            usuario.setFechaRegistro(fecha_registro);
            session.save(usuario);
            session.getTransaction().commit();
            response = true;
        } catch (HibernateException he) {
            response = false;
        }
        return response;
    }
    
    public Boolean editarUsuario(int id_usuario, String nombre_usuario, String clave, int tipo, String fecha_registro) {
        boolean response = false;
        try {
            Session session = HibernateUtil.getSessionFactory().openSession();
            session.beginTransaction();
            Usuarios usuario = (Usuarios) session.get(Usuarios.class, id_usuario);
            if (!"".equals(nombre_usuario)) {
                usuario.setUsuario(nombre_usuario);
            }
            if (!"".equals(clave)) {
                usuario.setClave(clave);
            }
            if (tipo > 0) {
                usuario.setTipo(tipo);
            }
            if (!"".equals(fecha_registro)) {
                usuario.setFechaRegistro(fecha_registro);
            }
            session.update(usuario);
            session.getTransaction().commit();
            response = true;
        } catch (HibernateException he) {
            response = false;
        }
        return response;
    }
    
    public Boolean borrarUsuario(int id_usuario) {
        boolean response = false;
        try {
            Session session = HibernateUtil.getSessionFactory().openSession();
            session.beginTransaction();
            Usuarios usuario = new Usuarios();
            usuario.setIdUsuario(id_usuario);
            session.delete(usuario);
            session.getTransaction().commit();
            response = true;
        } catch (HibernateException he) {
            response = false;
        }
        return response;
    }
    
    public boolean comprobar_existencia_producto_crear(String nombre_producto) {
        boolean respuesta = false;
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.beginTransaction();
        Query q = session.createQuery("from Productos p where p.nombreProducto like :patron");
        q.setString("patron", "%" + nombre_producto + "%");
        ArrayList lista = (ArrayList) q.list();
        if (lista.size() >= 1) {
            respuesta = true;
        } else {
            respuesta = false;
        }
        return respuesta;
    }
    
    public boolean comprobar_existencia_producto_editar(int id_producto, String nombre_producto) {
        boolean respuesta = false;
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.beginTransaction();
        Query q = session.createQuery("from Productos p where p.nombreProducto like :patron and p.idProducto!=" + id_producto);
        q.setString("patron", "%" + nombre_producto + "%");
        ArrayList lista = (ArrayList) q.list();
        if (lista.size() >= 1) {
            respuesta = true;
        } else {
            respuesta = false;
        }
        return respuesta;
    }
    
    public boolean comprobar_existencia_proveedor_crear(String nombre_empresa) {
        boolean respuesta = false;
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.beginTransaction();
        Query q = session.createQuery("from Proveedores p where p.nombreEmpresa like :patron");
        q.setString("patron", "%" + nombre_empresa + "%");
        ArrayList lista = (ArrayList) q.list();
        if (lista.size() >= 1) {
            respuesta = true;
        } else {
            respuesta = false;
        }
        return respuesta;
    }
    
    public boolean comprobar_existencia_proveedor_editar(int id_proveedor, String nombre_empresa) {
        boolean respuesta = false;
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.beginTransaction();
        Query q = session.createQuery("from Proveedores p where p.nombreEmpresa like :patron and p.idProveedor!=" + id_proveedor);
        q.setString("patron", "%" + nombre_empresa + "%");
        ArrayList lista = (ArrayList) q.list();
        if (lista.size() >= 1) {
            respuesta = true;
        } else {
            respuesta = false;
        }
        return respuesta;
    }
    
    public boolean comprobar_existencia_usuario_crear(String nombre_usuario) {
        boolean respuesta = false;
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.beginTransaction();
        Query q = session.createQuery("from Usuarios u where u.usuario like :patron");
        q.setString("patron", "%" + nombre_usuario + "%");
        ArrayList lista = (ArrayList) q.list();
        if (lista.size() >= 1) {
            respuesta = true;
        } else {
            respuesta = false;
        }
        return respuesta;
    }
    
    public boolean comprobar_existencia_usuario_editar(String nombre_usuario) {
        boolean respuesta = false;
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.beginTransaction();
        Query q = session.createQuery("from Usuarios u where u.usuario like :patron");
        q.setString("patron", "%" + nombre_usuario + "%");
        ArrayList lista = (ArrayList) q.list();
        if (lista.size() >= 1) {
            respuesta = true;
        } else {
            respuesta = false;
        }
        return respuesta;
    }
    
    public ArrayList listarProveedoresEnTabla(String patron) {
        ArrayList listaProveedores = new ArrayList();
        try {
            Session session = HibernateUtil.getSessionFactory().openSession();
            session.beginTransaction();
            Query q = session.createQuery("from Proveedores p where p.nombreEmpresa like :patron");
            q.setString("patron", "%" + patron + "%");
            ArrayList lista = (ArrayList) q.list();
            for (Object o : lista) {
                Proveedores proveedor = (Proveedores) o;
                listaProveedores.add(proveedor);
            }
        } catch (Exception e) {
            //
        }
        return listaProveedores;
    }
    
    public Proveedores cargarProveedorEnTabla(int id_proveedor_to_load) {
        Proveedores proveedor = new Proveedores();
        try {
            Session session = HibernateUtil.getSessionFactory().openSession();
            session.beginTransaction();
            proveedor = (Proveedores) session.get(Proveedores.class, id_proveedor_to_load);
            session.getTransaction().commit();
        } catch (HibernateException he) {
            //
        }
        return proveedor;
    }
    
    public ArrayList listarProductosEnTabla(String patron) {
        ArrayList listaProductos = new ArrayList();
        try {
            Session session = HibernateUtil.getSessionFactory().openSession();
            session.beginTransaction();
            Query q = session.createQuery("from Productos p where p.nombreProducto like :patron");
            q.setString("patron", "%" + patron + "%");
            ArrayList lista = (ArrayList) q.list();
            for (Object o : lista) {
                Productos producto = (Productos) o;
                listaProductos.add(producto);
            }
        } catch (Exception e) {
            //
        }
        return listaProductos;
    }
    
    public Productos cargarProductoEnTabla(int id_producto_to_load) {
        Productos producto = new Productos();
        try {
            Session session = HibernateUtil.getSessionFactory().openSession();
            session.beginTransaction();
            producto = (Productos) session.get(Productos.class, id_producto_to_load);
            session.getTransaction().commit();
        } catch (HibernateException he) {
            //
        }
        return producto;
    }
    
    public ArrayList listarUsuariosEnTabla(String patron) {
        ArrayList listaUsuarios = new ArrayList();
        try {
            Session session = HibernateUtil.getSessionFactory().openSession();
            session.beginTransaction();
            Query q = session.createQuery("from Usuarios u where u.usuario like :patron");
            q.setString("patron", "%" + patron + "%");
            ArrayList lista = (ArrayList) q.list();
            for (Object o : lista) {
                Usuarios usuario = (Usuarios) o;
                listaUsuarios.add(usuario);
            }
        } catch (Exception e) {
            //
        }
        return listaUsuarios;
    }
    
    public Usuarios cargarUsuarioEnTabla(int id_usuario_to_load) {
        Usuarios usuario = new Usuarios();
        try {
            Session session = HibernateUtil.getSessionFactory().openSession();
            session.beginTransaction();
            usuario = (Usuarios) session.get(Usuarios.class, id_usuario_to_load);
            session.getTransaction().commit();
        } catch (HibernateException he) {
            //
        }
        return usuario;
    }
    
    public String cargarNombreProveedor(int id_proveedor_to_load) {
        String nombre_empresa = "";
        try {
            Session session = HibernateUtil.getSessionFactory().openSession();
            session.beginTransaction();
            Proveedores proveedor = (Proveedores) session.get(Proveedores.class, id_proveedor_to_load);
            nombre_empresa = proveedor.getNombreEmpresa();
            session.getTransaction().commit();
        } catch (HibernateException he) {
            //
        }
        return nombre_empresa;
    }
    
}
