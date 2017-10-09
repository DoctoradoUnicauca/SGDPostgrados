package co.unicauca.proyectobase.controladores;

import co.unicauca.proyectobase.controladores.util.JsfUtil;
import co.unicauca.proyectobase.controladores.util.JsfUtil.PersistAction;
import co.unicauca.proyectobase.controladores.util.VistasCoordinador;
import co.unicauca.proyectobase.entidades.Estudiante;
import co.unicauca.proyectobase.entidades.GrupoTipoUsuario;
import co.unicauca.proyectobase.entidades.TipoUsuario;
import co.unicauca.proyectobase.entidades.Usuario;
import co.unicauca.proyectobase.facades.EstudianteFacade;
import co.unicauca.proyectobase.facades.GrupoTipoUsuarioFacade;
import co.unicauca.proyectobase.facades.UsuarioFacade;
import co.unicauca.proyectobase.controladores.util.Utilidades;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.ResourceBundle;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.ejb.EJB;
import javax.ejb.EJBException;
import javax.inject.Named;
import javax.enterprise.context.SessionScoped;
import javax.faces.component.UIComponent;
import javax.faces.context.FacesContext;
import javax.faces.convert.Converter;
import javax.faces.convert.FacesConverter;

@Named("estudianteController")
@SessionScoped
public class EstudianteController implements Serializable {

    @EJB
    private EstudianteFacade ejbFacade;
    @EJB
    private UsuarioFacade ejbUsuarioFacade;
    @EJB
    private GrupoTipoUsuarioFacade ejbGrupoTipoUsuarioFacade;

    private List<Estudiante> items = null;
    private Estudiante selected;
    private List<String> estados = null;

    public EstudianteController() {
    }

    public Estudiante getSelected() {
        return selected;
    }

    public void setSelected(Estudiante selected) {
        this.selected = selected;
    }

    protected void setEmbeddableKeys() {
    }

    protected void initializeEmbeddableKey() {
    }

    private EstudianteFacade getFacade() {
        return ejbFacade;
    }

    public String prepareCreate() {
        selected = new Estudiante();
        selected.setEstCedula(1234);
        selected.setEstCodigo("70_1234567896");
        selected.setEstCohorte(2017);
        selected.setEstCreditos(0);
        selected.setEstSemestre(1);
        selected.setEstTutor("carlitos");
        Usuario usu = new Usuario();
        usu.setNombres("harry");
        usu.setApellidos("potter");
        usu.setContrasena("asda");
        usu.setCorreo("harry@gmail.es");
        usu.setEstado(Utilidades.ESTADO_ACTIVO);

        selected.setUsuId(usu);
        initializeEmbeddableKey();
        return VistasCoordinador.registrarEstudiante();
    }

    public String create() {
        selected.setEstCreditos(0);
        Usuario usu = selected.getUsuId();
        usu.setContrasena(Utilidades.sha256(selected.getEstCodigo()));
        usu.setEstado(Utilidades.ESTADO_ACTIVO);
        persist(PersistAction.CREATE, ResourceBundle.getBundle("/BundleEstudiantes").getString("EstudianteCreated"));
        if (!JsfUtil.isValidationFailed()) {
            items = null;    // Invalidate list of items to trigger re-query.
        }
        // actualizar usuario
        usu = ejbUsuarioFacade.buscarPorCorreo(usu.getCorreo());
        // asignar tipo a usuario
        GrupoTipoUsuario gtu = new GrupoTipoUsuario();
        gtu.setUsuId(usu.getUsuId());
        gtu.setCorreo(usu.getCorreo());
        gtu.setTipo(new TipoUsuario(Utilidades.TIPO_USUARIO_ESTUDIANTE));
        // almacenar tipo en base de datos
        ejbGrupoTipoUsuarioFacade.edit(gtu);
        Utilidades.enviarCorreoCreacion(usu.getCorreo(), usu.getNombres(), selected.getEstCodigo());
        return VistasCoordinador.listarEstudiantes();
    }

    public String update() {
        ejbUsuarioFacade.edit(selected.getUsuId());
        selected.getUsuId().getGrupoTipoUsuario().setCorreo(selected.getUsuId().getCorreo());
        System.out.println("tipo:-- " + selected.getUsuId().getGrupoTipoUsuario().getTipo());
        ejbGrupoTipoUsuarioFacade.edit(selected.getUsuId().getGrupoTipoUsuario());

        Utilidades.enviarCorreoEdicion(selected);
        persist(PersistAction.UPDATE, ResourceBundle.getBundle("/BundleEstudiantes").getString("EstudianteUpdated"));
        return VistasCoordinador.listarEstudiantes();
    }

    public void destroy() {
        persist(PersistAction.DELETE, ResourceBundle.getBundle("/BundleEstudiantes").getString("EstudianteDeleted"));
        if (!JsfUtil.isValidationFailed()) {
            selected = null; // Remove selection
            items = null;    // Invalidate list of items to trigger re-query.
        }
    }

    public List<Estudiante> getItems() {
        if (items == null) {
            items = getFacade().findAll();
        }
        System.out.println("------------------------tamanio: " + items.size());
        return items;
    }

    private void persist(PersistAction persistAction, String successMessage) {
        if (selected != null) {
            setEmbeddableKeys();
            try {
                if (null == persistAction) {
//                    getFacade().remove(selected);
                } else {
                    switch (persistAction) {
                        case UPDATE:
                            getFacade().edit(selected);
                            break;
                        case CREATE:
                            getFacade().edit(selected);
                            break;
                        default:
                            getFacade().remove(selected);
                            break;
                    }
                    getFacade().flush();
                }
                JsfUtil.addSuccessMessage(successMessage);
            } catch (EJBException ex) {
                String msg = "";
                Throwable cause = ex.getCause();
                if (cause != null) {
                    msg = cause.getLocalizedMessage();
                }
                if (msg.length() > 0) {
                    JsfUtil.addErrorMessage(msg);
                } else {
                    JsfUtil.addErrorMessage(ex, ResourceBundle.getBundle("/BundleEstudiantes").getString("PersistenceErrorOccured"));
                }
            } catch (Exception ex) {
                Logger.getLogger(this.getClass().getName()).log(Level.SEVERE, null, ex);
                JsfUtil.addErrorMessage(ex, ResourceBundle.getBundle("/BundleEstudiantes").getString("PersistenceErrorOccured"));
            }
        }
    }

    public Estudiante getEstudiante(java.lang.Integer id) {
        return getFacade().find(id);
    }

    public List<Estudiante> getItemsAvailableSelectMany() {
        return getFacade().findAll();
    }

    public List<Estudiante> getItemsAvailableSelectOne() {
        return getFacade().findAll();
    }

    @FacesConverter(forClass = Estudiante.class)
    public static class EstudianteControllerConverter implements Converter {

        @Override
        public Object getAsObject(FacesContext facesContext, UIComponent component, String value) {
            if (value == null || value.length() == 0) {
                return null;
            }
            EstudianteController controller = (EstudianteController) facesContext.getApplication().getELResolver().
                    getValue(facesContext.getELContext(), null, "estudianteController");
            return controller.getEstudiante(getKey(value));
        }

        java.lang.Integer getKey(String value) {
            java.lang.Integer key;
            key = Integer.valueOf(value);
            return key;
        }

        String getStringKey(java.lang.Integer value) {
            StringBuilder sb = new StringBuilder();
            sb.append(value);
            return sb.toString();
        }

        @Override
        public String getAsString(FacesContext facesContext, UIComponent component, Object object) {
            if (object == null) {
                return null;
            }
            if (object instanceof Estudiante) {
                Estudiante o = (Estudiante) object;
                return getStringKey(o.getEstId());
            } else {
                Logger.getLogger(this.getClass().getName()).log(Level.SEVERE, "object {0} is of type {1}; expected type: {2}", new Object[]{object, object.getClass().getName(), Estudiante.class.getName()});
                return null;
            }
        }

    }

    //--------------------------------- ACCIONES -------------------------------
    public String verEstudiante(Estudiante est) {
        selected = est;
        return VistasCoordinador.verEstudiante();
    }

    public String editarEstudiante(Estudiante est) {
        selected = est;
        return VistasCoordinador.editarEstudiante();
    }

    public Usuario buscarPorCorreoExceptoConId(String correo, Integer id) {
        return ejbUsuarioFacade.buscarPorCorreoExceptoConId(correo, id);
    }

    public Estudiante buscarPorCodigoExceptoConId(String codigo, Integer id) {
        return ejbFacade.buscarPorCodigoExceptoConId(codigo, id);
    }

    public Estudiante buscarPorCedulaExceptoConId(Integer codigo, Integer id) {
        return ejbFacade.buscarPorCedulaExceptoConId(codigo, id);
    }

    //--------------------------------- NUEVOS GETTER SETTER -------------------
    public List<String> getEstados() {
        if (estados == null) {
            estados = new ArrayList();
            estados.add(Utilidades.ESTADO_ACTIVO);
            estados.add(Utilidades.ESTADO_INACTIVO);
        }
        return estados;
    }

    public int[] getListaAnios() {
        Calendar cal = Calendar.getInstance();
        int anioInicio = 1999;
        int anioActual = cal.get(Calendar.YEAR);
        int[] vectorA = new int[anioActual - anioInicio];
        for (int i = 0; i < vectorA.length; i++) {
            vectorA[i] = anioActual--;
        }
        return vectorA;
    }

}
