package com.greatsec.demo.modules.sys.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.greatsec.demo.common.persistence.DataEntity;

@Entity
@Table(name = "sys_code")
@DynamicInsert
@DynamicUpdate
public class Code extends DataEntity {

	/**
     * 
     */
	private static final long serialVersionUID = 1L;

	/**
	 * 类型
	 */
	public enum Type {

		/** 订单 */
		order,

		/** 样本编号 */
		sample,

		/** 发票 **/
		invoice
	}

	private Long id;

	private Type type;

	private String beforePrefixes;

	private String incrementPart;

	private String afterPrefixes;

	private Long number;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	@Column(name = "type")
	@Enumerated(EnumType.STRING)
	public Type getType() {
		return type;
	}

	public void setType(Type type) {
		this.type = type;
	}

	@Column(name = "prefixes_before")
	public String getBeforePrefixes() {
		return beforePrefixes;
	}

	public void setBeforePrefixes(String beforePrefixes) {
		this.beforePrefixes = beforePrefixes;
	}

	@Column(name = "increment_part")
	public String getIncrementPart() {
		return incrementPart;
	}

	public void setIncrementPart(String incrementPart) {
		this.incrementPart = incrementPart;
	}

	@Column(name = "prefixes_after")
	public String getAfterPrefixes() {
		return afterPrefixes;
	}

	public void setAfterPrefixes(String afterPrefixes) {
		this.afterPrefixes = afterPrefixes;
	}

	@Column(name = "number")
	public Long getNumber() {
		return number;
	}

	public void setNumber(Long number) {
		this.number = number;
	}

}
