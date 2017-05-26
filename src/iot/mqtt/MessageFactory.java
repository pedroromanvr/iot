/*
 * Copyright (C) 2017 pevilla
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
package iot.mqtt;

import java.util.logging.Logger;
import org.eclipse.paho.client.mqttv3.persist.MemoryPersistence;

/**
 *
 * @author pevilla
 */
public class MessageFactory {
    private String m_topic              = null; // Topic to suscribe/publish
    private String m_content            = null; //
    private String m_broker             = null;
    private String m_clientId           = null;
    private MemoryPersistence m_pers    = null;
    private int n_qos                   = -1;
    
    // Username and password, if needed
    private String m_username           = null;
    private char[] m_password           = null;
    
    // Instance
    private static MessageFactory s_instance = null;
    
    /**
     * Constructor, only way to use this factory is getInstance()
     */
    private MessageFactory()
    {
    }
    
    public static synchronized MessageFactory getInstance()
    {
        if (s_instance == null) {
            s_instance = new MessageFactory();
        }
        return s_instance;
    }

    public String getTopic() {
        return m_topic;
    }

    public void setM_topic(String m_topic) {
        this.m_topic = m_topic;
    }

    public String getM_content() {
        return m_content;
    }

    public void setM_content(String m_content) {
        this.m_content = m_content;
    }

    public String getM_broker() {
        return m_broker;
    }

    public void setM_broker(String m_broker) {
        this.m_broker = m_broker;
    }

    public String getM_clientId() {
        return m_clientId;
    }

    public void setM_clientId(String m_clientId) {
        this.m_clientId = m_clientId;
    }

    public int getN_qos() {
        return n_qos;
    }

    public void setN_qos(int n_qos) {
        this.n_qos = n_qos;
    }

    public String getM_username() {
        return m_username;
    }

    public void setM_username(String m_username) {
        this.m_username = m_username;
    }

    public char[] getM_password() {
        return m_password;
    }

    public void setM_password(char[] m_password) {
        this.m_password = m_password;
    }
}
