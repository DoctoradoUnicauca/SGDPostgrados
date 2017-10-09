/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package co.unicauca.proyectobase.facades;

import co.unicauca.proyectobase.entidades.Documentacion;
import co.unicauca.proyectobase.entidades.Usuario;
import java.math.BigInteger;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

/**
 *
 * @author debian
 */
@Stateless
public class DocumentacionFacade extends AbstractFacade<Documentacion> {

    @PersistenceContext(unitName = "ProyectoDoctoradoPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public DocumentacionFacade() {
        super(Documentacion.class);
    }

    public List<Documentacion> buscarPorVisado(String visado) {
        Query query = em.createNamedQuery("Documentacion.findByDocVisado");
        query.setParameter("docVisado", visado);
        List<Documentacion> findUsuario = query.getResultList();
        return findUsuario;
    }
    public List<Documentacion> buscarPorEstudiante(Integer idEstudiante) {
        Query query = em.createNamedQuery("Documentacion.findByIdEstudiante");
        query.setParameter("estId", idEstudiante);
        List<Documentacion> documentos = query.getResultList();
        return documentos;
    }
//
//    public int getIdArchivo() {
//        try {
//            String queryStr;
//            queryStr = "SELECT AUTO_INCREMENT FROM  INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'doctorado_2' AND TABLE_NAME = 'archivo'";
//            javax.persistence.Query query = getEntityManager().createNativeQuery(queryStr);
//            List results = query.getResultList();
//            int autoIncrement = ((Integer) results.get(0));
//            return autoIncrement;
//        } catch (Exception e) {
//            System.out.println("Error " + e.getMessage());
//            System.out.println(e);
//            return -1;
//        }
//    }

    public int getnumFilasPubRev() {
        try {
            String queryStr;
            queryStr = "SELECT AUTO_INCREMENT FROM  INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'doctorado_2' AND TABLE_NAME = 'documentacion'";
            javax.persistence.Query query = getEntityManager().createNativeQuery(queryStr);
            List results = query.getResultList();
            int autoIncrement = ((BigInteger) results.get(0)).intValue();
            return autoIncrement;
        } catch (Exception e) {
            System.out.println("Error " + e.getMessage());
            System.out.println(e);
            return -1;
        }
    }

    public int CountByMonthYear(String anio, String mes) {

        String comSimple = "\'";
        String queryStr;
        queryStr = "SELECT COUNT(*) FROM documentacion WHERE YEAR(documentacion.doc_fecha_registro) =" + comSimple + anio + comSimple + "  AND Month(documentacion.doc_fecha_registro) = " + comSimple + mes + comSimple;

        javax.persistence.Query query = getEntityManager().createNativeQuery(queryStr);
        List results = query.getResultList();
        int numeroPub = ((Long) results.get(0)).intValue();
        return numeroPub;

    }

    public int CountByMonthYearVis(String anio, String mes) {

        String comSimple = "\'";
        String queryStr;
        queryStr = "SELECT COUNT(*) FROM documentacion WHERE YEAR(documentacion.doc_fecha_visado) =" + comSimple + anio + comSimple + "  AND Month(documentacion.doc_fecha_visado) = " + comSimple + mes + comSimple;

        javax.persistence.Query query = getEntityManager().createNativeQuery(queryStr);
        List results = query.getResultList();
        int numeroPub = ((Long) results.get(0)).intValue();
        return numeroPub;

    }
}
