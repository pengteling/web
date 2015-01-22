<!--#include file="../../FiveInc/conn.asp"-->
<!--#include file="../admin.asp"-->
<!-- #include file="../Inc/Head.asp" -->
<input type="button" value="返回上页" onClick="location.href='manage_jobbook.asp'">
<table  id="biaoge">
              <tr>
                <td width="540" nowrap colspan="5"><p align="left"><strong>求职意向 </strong></p></td>
                <td width="108" rowspan="5"><p align="center">
                  
                  <div class="ny-zxbm-zp-h"><img src="/images/ny-zxbm-zp.jpg" width="95" height="112" id="photo"/></div>
                  <div align="center">
                  <input type="hidden" value=""  name="field138" id="field138">
                    <!--<input type="button" value="上传照片"  name="image3" id="image3" class="ny-zxbm-sczp-b">-->
                  </div>
                  </p></td>
              </tr>
             
              <tr>
                <td width="128" nowrap><p align="right"><span class="ny-zxbm-fuhao">*</span>应聘公司 </p></td>
                <td width="412" nowrap colspan="4" ><p align="left">
                    <input type="text" name="field1" id="field1" class="qzyx340 require">
                  </p></td>
              </tr>
              <tr>
                <td width="128" nowrap><p align="right"><span class="ny-zxbm-fuhao">*</span>应聘职位 </p></td>
                <td width="412" nowrap colspan="4"><p align="left">
                    <input type="text" name="field2" id="field2" class="qzyx340 require">
                  </p></td>
              </tr>
              <tr>
                <td width="128" nowrap><p align="right"><span class="ny-zxbm-fuhao">*</span>期望月薪 </p></td>
                <td width="412" nowrap colspan="4"><p align="left">
                    <input type="text" name="field3" id="field3" class="qzyx340 require">
                  </p></td>
              </tr>
              <tr>
                <td width="540" nowrap colspan="5"><p align="left"><strong><span class="ny-zxbm-fuhao">*</span></strong><strong>联系方式（非常重要） </strong></p></td>
              </tr>
              <tr>
                <td width="128" nowrap><p align="right"><span class="ny-zxbm-fuhao">*</span>座机 </p></td>
                <td width="172" nowrap colspan="2"><p align="left">
                    <input type="text" name="field4" id="field4" class="lxfs150 require">
                  </p></td>
                <td width="111" nowrap><p align="right">电子邮件 </p></td>
                <td width="236" nowrap colspan="2"><p align="left">
                    <input type="text" name="field5" id="field5" class="lxfs150">
                  </p></td>
              </tr>
              <tr>
                <td width="128" nowrap><p align="right"><span class="ny-zxbm-fuhao">*</span>手机 </p></td>
                <td width="172" nowrap colspan="2"><p align="left">
                    <input type="text" name="field6" id="field6" class="lxfs150 require">
                  </p></td>
                <td width="111" nowrap><p align="right">QQ</p></td>
                <td width="236" nowrap colspan="2"><p align="left">
                    <input type="text" name="field7" id="field7" class="lxfs150">
                  </p></td>
              </tr>
              <tr>
                <td width="128" nowrap><p align="right">小灵通 </p></td>
                <td width="172" nowrap colspan="2"><p align="left">
                    <input type="text" name="field8" id="field8" class="lxfs150">
                  </p></td>
                <td width="111" nowrap><p align="right">MSN</p></td>
                <td width="236" nowrap colspan="2"><p align="left">
                    <input type="text" name="field9" id="field9" class="lxfs150">
                  </p></td>
              </tr>
              <tr>
                <td width="128" nowrap><p align="right"><span class="ny-zxbm-fuhao">*</span>通信地址及邮编 </p></td>
                <td width="520" nowrap colspan="5"><p align="left">
                    <input type="text" name="field10" id="field10" class="lxfs490 require">
                  </p></td>
              </tr>
              <tr>
                <td width="648" nowrap colspan="6"><p align="left"><strong><span class="ny-zxbm-fuhao">*</span></strong><strong>基本信息（非常重要） </strong></p></td>
              </tr>
              <tr>
                <td width="128" nowrap><p align="right"><span class="ny-zxbm-fuhao">*</span>姓名 </p></td>
                <td width="172" nowrap colspan="2"><p align="left">
                    <input type="text" name="field11" id="field11" class="jbxx150 require">
                  </p></td>
                <td width="111" nowrap><p align="right"><span class="ny-zxbm-fuhao">*</span>最高学历 </p></td>
                <td width="236" nowrap colspan="2"><p align="left">
                    <input type="text" name="field12" id="field12" class="jbxx150 require">
                  </p></td>
              </tr>
              <tr>
                <td width="128" nowrap><p align="right"><span class="ny-zxbm-fuhao">*</span>性别 </p></td>
                <td width="172" nowrap colspan="2"><p align="left">
                    <input type="text" name="field13" id="field13" class="jbxx150">
                  </p></td>
                <td width="111" nowrap><p align="right">所学专业 </p></td>
                <td width="236" nowrap colspan="2"><p align="left">
                    <input type="text" name="field14" id="field14" class="jbxx150">
                  </p></td>
              </tr>
              <tr>
                <td width="128" nowrap><p align="right"><span class="ny-zxbm-fuhao">*</span>出生日期 </p></td>
                <td width="172" nowrap colspan="2"><p align="left">
                    <input type="text" name="field15" id="field15" class="jbxx150">
                  </p></td>
                <td width="111" nowrap><p align="right"><span class="ny-zxbm-fuhao">*</span>参加工作时间 </p></td>
                <td width="236" nowrap colspan="2"><p align="left">
                    <input type="text" name="field16" id="field16" class="jbxx150">
                  </p></td>
              </tr>
              <tr>
                <td width="128" nowrap><p align="right"><span class="ny-zxbm-fuhao">*</span>身份证号码 </p></td>
                <td width="172" nowrap colspan="2"><p align="left">
                    <input type="text" name="field17" id="field17" class="jbxx150">
                  </p></td>
                <td width="111" nowrap><p align="right">技术职称 </p></td>
                <td width="236" nowrap colspan="2"><p align="left">
                    <input type="text" name="field18" id="field18" class="jbxx150">
                  </p></td>
              </tr>
              <tr>
                <td width="128" nowrap><p align="right"><span class="ny-zxbm-fuhao">*</span>籍贯 </p></td>
                <td width="172" nowrap colspan="2"><p align="left">
                    <input type="text" name="field19" id="field19" class="jbxx150">
                  </p></td>
                <td width="111" nowrap><p align="right"><span class="ny-zxbm-fuhao">*</span>身高(M)</p></td>
                <td width="236" nowrap colspan="2"><p align="left">
                    <input type="text" name="field20" id="field20" class="jbxx150">
                  </p></td>
              </tr>
              <tr>
                <td width="128" nowrap><p align="right"><span class="ny-zxbm-fuhao">*</span>户口所在地 </p></td>
                <td width="172" nowrap colspan="2"><p align="left">
                    <input type="text" name="field21" id="field21" class="jbxx150">
                  </p></td>
                <td width="111" nowrap><p align="right"><span class="ny-zxbm-fuhao">*</span>体重(KG)</p></td>
                <td width="236" nowrap colspan="2"><p align="left">
                    <input type="text" name="field22" id="field22" class="jbxx150">
                  </p></td>
              </tr>
              <tr>
                <td width="128" nowrap><p align="right"><span class="ny-zxbm-fuhao">*</span>户口属性 </p></td>
                <td width="172" nowrap colspan="2"><p align="left">
                    <input type="text" name="field23" id="field23" class="jbxx150">
                  </p></td>
                <td width="111" nowrap><p align="right">血型 </p></td>
                <td width="236" nowrap colspan="2"><p align="left">
                    <input type="text" name="field24" id="field24" class="jbxx150">
                  </p></td>
              </tr>
              <tr>
                <td width="128" nowrap><p align="right"><span class="ny-zxbm-fuhao">*</span>现住址及邮编 </p></td>
                <td width="172" nowrap colspan="2"><p align="left">
                    <input type="text" name="field25" id="field25" class="jbxx150">
                  </p></td>
                <td width="111" nowrap><p align="right">婚姻状况 </p></td>
                <td width="236" nowrap colspan="2"><p align="left">
                    <input type="text" name="field26" id="field26" class="jbxx150">
                  </p></td>
              </tr>
              <tr>
                <td width="128" nowrap><p align="right">民族 </p></td>
                <td width="172" nowrap colspan="2"><p align="left">
                    <input type="text" name="field27" id="field27" class="jbxx150">
                  </p></td>
                <td width="111" nowrap><p align="right">政治面貌 </p></td>
                <td width="236" nowrap colspan="2"><p align="left">
                    <input type="text" name="field28" id="field28" class="jbxx150">
                  </p></td>
              </tr>
              <tr>
                <td width="223" nowrap colspan="2"><p align="center"><span class="ny-zxbm-fuhao">*</span>重大疾病、精神病或传染病史说明 </p></td>
                <td width="425" nowrap colspan="4"><p align="left">
                    <input type="text" name="field29" id="field29" class="jbxx400">
                  </p></td>
              </tr>
              <tr>
                <td width="648" nowrap colspan="6"><p align="left"><strong><span class="ny-zxbm-fuhao">*</span></strong><strong>家庭关系 </strong></p></td>
              </tr>
              <tr>
                <td width="128" nowrap><p align="center"><span class="ny-zxbm-fuhao">*</span>姓名 </p></td>
                <td width="95" nowrap><p align="center"><span class="ny-zxbm-fuhao">*</span>与本人关系 </p></td>
                <td width="78" nowrap><p align="center"><span class="ny-zxbm-fuhao">*</span>职业性质 </p></td>
                <td width="111" nowrap><p align="center"><span class="ny-zxbm-fuhao">*</span>电话 </p></td>
                <td width="236" nowrap colspan="2"><p align="center"><span class="ny-zxbm-fuhao">*</span>通讯地址及邮编 </p></td>
              </tr>
              <tr>
                <td width="128" nowrap><p align="left">
                    <input type="text" name="field30" id="field30" class="jtgx120">
                  </p></td>
                <td width="95" nowrap><p align="left">
                    <input type="text" name="field31" id="field31" class="jtgx90">
                  </p></td>
                <td width="78" nowrap><p align="left">
                    <input type="text" name="field32" id="field32" class="jtgx75">
                  </p></td>
                <td width="111" nowrap><p align="left">
                    <input type="text" name="field33" id="field33" class="jtgx100">
                  </p></td>
                <td width="236" nowrap colspan="2"><p align="left">
                    <input type="text" name="field34" id="field34" class="jtgx225">
                  </p></td>
              </tr>
              <tr>
                <td width="128" nowrap><p align="left">
                    <input type="text" name="field35" id="field35" class="jtgx120">
                  </p></td>
                <td width="95" nowrap><p align="left">
                    <input type="text" name="field36" id="field36" class="jtgx90">
                  </p></td>
                <td width="78" nowrap><p align="left">
                    <input type="text" name="field37" id="field37" class="jtgx75">
                  </p></td>
                <td width="111" nowrap><p align="left">
                    <input type="text" name="field38" id="field38" class="jtgx100">
                  </p></td>
                <td width="236" nowrap colspan="2"><p align="left">
                    <input type="text" name="field39" id="field39" class="jtgx225">
                  </p></td>
              </tr>
              <tr>
                <td width="128" nowrap><p align="left">
                    <input type="text" name="field40" id="field40" class="jtgx120">
                  </p></td>
                <td width="95" nowrap><p align="left">
                    <input type="text" name="field41" id="field41" class="jtgx90">
                  </p></td>
                <td width="78" nowrap><p align="left">
                    <input type="text" name="field42" id="field42" class="jtgx75">
                  </p></td>
                <td width="111" nowrap><p align="left">
                    <input type="text" name="field43" id="field43" class="jtgx100">
                  </p></td>
                <td width="236" nowrap colspan="2"><p align="left">
                    <input type="text" name="field44" id="field44" class="jtgx225">
                  </p></td>
              </tr>
              <tr>
                <td width="648" nowrap colspan="6"><p align="left"><strong><span class="ny-zxbm-fuhao">*</span></strong><strong>教育经历（从中学起记录） </strong></p></td>
              </tr>
              <tr>
                <td width="128" nowrap><p align="center"><span class="ny-zxbm-fuhao">*</span>起始年月 </p></td>
                <td width="95" nowrap><p align="center"><span class="ny-zxbm-fuhao">*</span>结束年月 </p></td>
                <td width="78" nowrap><p align="center"><span class="ny-zxbm-fuhao">*</span>学校名称 </p></td>
                <td width="111" nowrap><p align="center">所学专业 </p></td>
                <td width="128" nowrap><p align="center"><span class="ny-zxbm-fuhao">*</span>学历学位证名称 </p></td>
                <td width="108" nowrap><p align="center">备注 </p></td>
              </tr>
              <tr>
                <td width="128" nowrap><p align="left">
                    <input type="text" name="field45" id="field45" class="jtgx120">
                  </p></td>
                <td width="95" nowrap><p align="left">
                    <input type="text" name="field46" id="field46" class="jtgx90">
                  </p></td>
                <td width="78" nowrap><p align="left">
                    <input type="text" name="field47" id="field47" class="jtgx75">
                  </p></td>
                <td width="111" nowrap><p align="left">
                    <input type="text" name="field48" id="field48" class="jtgx100">
                  </p></td>
                <td width="128" nowrap><p align="left">
                    <input type="text" name="field49" id="field49" class="jtgx120">
                  </p></td>
                <td width="108" nowrap><p align="left">
                    <input type="text" name="field50" id="field50" class="jtgx100">
                  </p></td>
              </tr>
              <tr>
                <td width="128" nowrap><p align="left">
                    <input type="text" name="field51" id="field51" class="jtgx120">
                  </p></td>
                <td width="95" nowrap><p align="left">
                    <input type="text" name="field52" id="field52" class="jtgx90">
                  </p></td>
                <td width="78" nowrap><p align="left">
                    <input type="text" name="field53" id="field53" class="jtgx75">
                  </p></td>
                <td width="111" nowrap><p align="left">
                    <input type="text" name="field54" id="field54" class="jtgx100">
                  </p></td>
                <td width="128" nowrap><p align="left">
                    <input type="text" name="field55" id="field55" class="jtgx120">
                  </p></td>
                <td width="108" nowrap><p align="left">
                    <input type="text" name="field56" id="field56" class="jtgx100">
                  </p></td>
              </tr>
              <tr>
                <td width="128" nowrap><p align="left">
                    <input type="text" name="field57" id="field57" class="jtgx120">
                  </p></td>
                <td width="95" nowrap><p align="left">
                    <input type="text" name="field58" id="field58" class="jtgx90">
                  </p></td>
                <td width="78" nowrap><p align="left">
                    <input type="text" name="field59" id="field59" class="jtgx75">
                  </p></td>
                <td width="111" nowrap><p align="left">
                    <input type="text" name="field60" id="field60" class="jtgx100">
                  </p></td>
                <td width="128" nowrap><p align="left">
                    <input type="text" name="field61" id="field61" class="jtgx120">
                  </p></td>
                <td width="108" nowrap><p align="left">
                    <input type="text" name="field62" id="field62" class="jtgx100">
                  </p></td>
              </tr>
              <tr>
                <td width="128" nowrap><p align="left">
                    <input type="text" name="field63" id="field63" class="jtgx120">
                  </p></td>
                <td width="95" nowrap><p align="left">
                    <input type="text" name="field64" id="field64" class="jtgx90">
                  </p></td>
                <td width="78" nowrap><p align="left">
                    <input type="text" name="field65" id="field65" class="jtgx75">
                  </p></td>
                <td width="111" nowrap><p align="left">
                    <input type="text" name="field66" id="field66" class="jtgx100">
                  </p></td>
                <td width="128" nowrap><p align="left">
                    <input type="text" name="field67" id="field67" class="jtgx120">
                  </p></td>
                <td width="108" nowrap><p align="left">
                    <input type="text" name="field68" id="field68" class="jtgx100">
                  </p></td>
              </tr>
              <tr>
                <td width="648" nowrap colspan="6"><p align="left"><strong>培训经历 </strong></p></td>
              </tr>
              <tr>
                <td width="128" nowrap><p align="center">培训时间 </p></td>
                <td width="95" nowrap><p align="center">培训小时 </p></td>
                <td width="78" nowrap><p align="center">培训机构 </p></td>
                <td width="111" nowrap><p align="center">培训主题 </p></td>
                <td width="128" nowrap><p align="center">证书名称 </p></td>
                <td width="108" nowrap><p align="center">备注 </p></td>
              </tr>
              <tr>
                <td width="128" nowrap><p align="left">
                    <input type="text" name="field69" id="field69" class="jtgx120">
                  </p></td>
                <td width="95" nowrap><p align="left">
                    <input type="text" name="field70" id="field70" class="jtgx90">
                  </p></td>
                <td width="78" nowrap><p align="left">
                    <input type="text" name="field71" id="field71" class="jtgx75">
                  </p></td>
                <td width="111" nowrap><p align="left">
                    <input type="text" name="field72" id="field72" class="jtgx100">
                  </p></td>
                <td width="128" nowrap><p align="left">
                    <input type="text" name="field73" id="field73" class="jtgx120">
                  </p></td>
                <td width="108" nowrap><p align="left">
                    <input type="text" name="field74" id="field74" class="jtgx100">
                  </p></td>
              </tr>
              <tr>
                <td width="128" nowrap><p align="left">
                    <input type="text" name="field75" id="field75" class="jtgx120">
                  </p></td>
                <td width="95" nowrap><p align="left">
                    <input type="text" name="field76" id="field76" class="jtgx90">
                  </p></td>
                <td width="78" nowrap><p align="left">
                    <input type="text" name="field77" id="field77" class="jtgx75">
                  </p></td>
                <td width="111" nowrap><p align="left">
                    <input type="text" name="field78" id="field78" class="jtgx100">
                  </p></td>
                <td width="128" nowrap><p align="left">
                    <input type="text" name="field79" id="field79" class="jtgx120">
                  </p></td>
                <td width="108" nowrap><p align="left">
                    <input type="text" name="field80" id="field80" class="jtgx100">
                  </p></td>
              </tr>
              <tr>
                <td width="128" nowrap><p align="left">
                    <input type="text" name="field81" id="field81" class="jtgx120">
                  </p></td>
                <td width="95" nowrap><p align="left">
                    <input type="text" name="field82" id="field82" class="jtgx90">
                  </p></td>
                <td width="78" nowrap><p align="left">
                    <input type="text" name="field83" id="field83" class="jtgx75">
                  </p></td>
                <td width="111" nowrap><p align="left">
                    <input type="text" name="field84" id="field84" class="jtgx100">
                  </p></td>
                <td width="128" nowrap><p align="left">
                    <input type="text" name="field85" id="field85" class="jtgx120">
                  </p></td>
                <td width="108" nowrap><p align="left">
                    <input type="text" name="field86" id="field86" class="jtgx100">
                  </p></td>
              </tr>
              <tr>
                <td width="128" nowrap><p align="left">
                    <input type="text" name="field87" id="field87" class="jtgx120">
                  </p></td>
                <td width="95" nowrap><p align="left">
                    <input type="text" name="field88" id="field88" class="jtgx90">
                  </p></td>
                <td width="78" nowrap><p align="left">
                    <input type="text" name="field89" id="field89" class="jtgx75">
                  </p></td>
                <td width="111" nowrap><p align="left">
                    <input type="text" name="field90" id="field90" class="jtgx100">
                  </p></td>
                <td width="128" nowrap><p align="left">
                    <input type="text" name="field91" id="field91" class="jtgx120">
                  </p></td>
                <td width="108" nowrap><p align="left">
                    <input type="text" name="field92" id="field92" class="jtgx100">
                  </p></td>
              </tr>
              <tr>
                <td width="128" nowrap><p align="left">
                    <input type="text" name="field93" id="field93" class="jtgx120">
                  </p></td>
                <td width="95" nowrap><p align="left">
                    <input type="text" name="field94" id="field94" class="jtgx90">
                  </p></td>
                <td width="78" nowrap><p align="left">
                    <input type="text" name="field95" id="field95" class="jtgx75">
                  </p></td>
                <td width="111" nowrap><p align="left">
                    <input type="text" name="field96" id="field96" class="jtgx100">
                  </p></td>
                <td width="128" nowrap><p align="left">
                    <input type="text" name="field97" id="field97" class="jtgx120">
                  </p></td>
                <td width="108" nowrap><p align="left">
                    <input type="text" name="field98" id="field98" class="jtgx100">
                  </p></td>
              </tr>
              <tr>
                <td width="648" nowrap colspan="6"><p align="left"><strong><span class="ny-zxbm-fuhao">*</span></strong><strong>工作经历 </strong></p></td>
              </tr>
              <tr>
                <td width="128" nowrap><p align="center">起始年月 </p></td>
                <td width="95" nowrap><p align="center">结束年月 </p></td>
                <td width="78" nowrap><p align="center">工作单位 </p></td>
                <td width="111" nowrap><p align="center">职位 </p></td>
                <td width="128" nowrap><p align="center">月薪水平 </p></td>
                <td width="108" nowrap><p align="center">离职原因 </p></td>
              </tr>
              <tr>
                <td width="128" nowrap><p align="left">
                    <input type="text" name="field99" id="field99" class="jtgx120">
                  </p></td>
                <td width="95" nowrap><p align="left">
                    <input type="text" name="field100" id="field100" class="jtgx90">
                  </p></td>
                <td width="78" nowrap><p align="left">
                    <input type="text" name="field101" id="field101" class="jtgx75">
                  </p></td>
                <td width="111" nowrap><p align="left">
                    <input type="text" name="field102" id="field102" class="jtgx100">
                  </p></td>
                <td width="128" nowrap><p align="left">
                    <input type="text" name="field103" id="field103" class="jtgx120">
                  </p></td>
                <td width="108" nowrap><p align="left">
                    <input type="text" name="field104" id="field104" class="jtgx100">
                  </p></td>
              </tr>
              <tr>
                <td width="128" nowrap><p align="left">
                    <input type="text" name="field105" id="field105" class="jtgx120">
                  </p></td>
                <td width="95" nowrap><p align="left">
                    <input type="text" name="field106" id="field106" class="jtgx90">
                  </p></td>
                <td width="78" nowrap><p align="left">
                    <input type="text" name="field107" id="field107" class="jtgx75">
                  </p></td>
                <td width="111" nowrap><p align="left">
                    <input type="text" name="field108" id="field108" class="jtgx100">
                  </p></td>
                <td width="128" nowrap><p align="left">
                    <input type="text" name="field109" id="field109" class="jtgx120">
                  </p></td>
                <td width="108" nowrap><p align="left">
                    <input type="text" name="field110" id="field110" class="jtgx100">
                  </p></td>
              </tr>
              <tr>
                <td width="128" nowrap><p align="left">
                    <input type="text" name="field111" id="field111" class="jtgx120">
                  </p></td>
                <td width="95" nowrap><p align="left">
                    <input type="text" name="field112" id="field112" class="jtgx90">
                  </p></td>
                <td width="78" nowrap><p align="left">
                    <input type="text" name="field113" id="field113" class="jtgx75">
                  </p></td>
                <td width="111" nowrap><p align="left">
                    <input type="text" name="field114" id="field114" class="jtgx100">
                  </p></td>
                <td width="128" nowrap><p align="left">
                    <input type="text" name="field115" id="field115" class="jtgx120">
                  </p></td>
                <td width="108" nowrap><p align="left">
                    <input type="text" name="field116" id="field116" class="jtgx100">
                  </p></td>
              </tr>
              <tr>
                <td width="128" nowrap><p align="left">
                    <input type="text" name="field117" id="field117" class="jtgx120">
                  </p></td>
                <td width="95" nowrap><p align="left">
                    <input type="text" name="field118" id="field118" class="jtgx90">
                  </p></td>
                <td width="78" nowrap><p align="left">
                    <input type="text" name="field119" id="field119" class="jtgx75">
                  </p></td>
                <td width="111" nowrap><p align="left">
                    <input type="text" name="field120" id="field120" class="jtgx100">
                  </p></td>
                <td width="128" nowrap><p align="left">
                    <input type="text" name="field121" id="field121" class="jtgx120">
                  </p></td>
                <td width="108" nowrap><p align="left">
                    <input type="text" name="field122" id="field122" class="jtgx100">
                  </p></td>
              </tr>
              <tr>
                <td width="128" nowrap><p align="left">
                    <input type="text" name="field123" id="field123" class="jtgx120">
                  </p></td>
                <td width="95" nowrap><p align="left">
                    <input type="text" name="field124" id="field124" class="jtgx90">
                  </p></td>
                <td width="78" nowrap><p align="left">
                    <input type="text" name="field125" id="field125" class="jtgx75">
                  </p></td>
                <td width="111" nowrap><p align="left">
                    <input type="text" name="field126" id="field126" class="jtgx100">
                  </p></td>
                <td width="128" nowrap><p align="left">
                    <input type="text" name="field127" id="field127" class="jtgx120">
                  </p></td>
                <td width="108" nowrap><p align="left">
                    <input type="text" name="field128" id="field128" class="jtgx100">
                  </p></td>
              </tr>
              <tr>
                <td width="648" nowrap colspan="6"><p align="left"><strong>通用技能 </strong></p></td>
              </tr>
              <tr>
                <td width="128" nowrap><p align="right">第一外语语种 </p></td>
                <td width="172" nowrap colspan="2"><p align="center">
                    <input type="text" name="field129" id="field129" class="tyjn160">
                  </p></td>
                <td width="111" nowrap><p align="right">计算机水平 </p></td>
                <td width="236" nowrap colspan="2"><p align="center">
                    <input type="text" name="field130" id="field130" class="tyjn225">
                  </p></td>
              </tr>
              <tr>
                <td width="128" nowrap><p align="right">水平等级 </p></td>
                <td width="172" nowrap colspan="2"><p align="center">
                    <input type="text" name="field131" id="field131" class="tyjn160">
                  </p></td>
                <td width="111" nowrap><p align="right">普通话水平 </p></td>
                <td width="236" nowrap colspan="2"><p align="center">
                    <input type="text" name="field132" id="field132" class="tyjn225">
                  </p></td>
              </tr>
              <tr>
                <td width="128" nowrap><p align="right">第二外语语种 </p></td>
                <td width="172" nowrap colspan="2"><p align="center">
                    <input type="text" name="field133" id="field133" class="tyjn160">
                  </p></td>
                <td width="111" nowrap><p align="right">驾驶执照 </p></td>
                <td width="236" nowrap colspan="2"><p align="center">
                    <input type="text" name="field134" id="field134" class="tyjn225">
                  </p></td>
              </tr>
              <tr>
                <td width="128" nowrap><p align="right">水平等级 </p></td>
                <td width="172" nowrap colspan="2"><p align="center">
                    <input type="text" name="field135" id="field135" class="tyjn160">
                  </p></td>
                <td width="111" nowrap><p align="right">其他证书 </p></td>
                <td width="236" nowrap colspan="2"><p align="center">
                    <input type="text" name="field136" id="field136" class="tyjn225">
                  </p></td>
              </tr>
              <tr>
                <td width="648" nowrap colspan="6"><p align="left"><strong><span class="ny-zxbm-fuhao">*</span></strong><strong>承诺 </strong></p></td>
              </tr>
              <tr>
                <td width="648" colspan="6"><p align="left">    本人自愿申请加入宗申产业集团，本着诚实守信的原则，在此郑重承诺：上述个人信息完全真实、准确，若因失实所造成的一切后果及责任由本人全部承担；同时人力资源部已将职位申请书的重要度和注意事项传达于我，我已确认完全了解其含义。<br>
                  </p>
                  <div align="right">应聘承诺人：<span class="ny-zxbm-sm">
                    <input type="text" name="field137" id="field137" class=" ny-zxbm-sm-w">
                    </span>
                  </div>
                  <div align="right">日期：<span class="ny-zxbm-sm">
                    <input type="text" name="field137" id="field137" class=" ny-zxbm-sm-w-2">
                    </span></div></td>
              </tr>
              <tr>
                <td width="648" nowrap colspan="6"><p align="left"><span class="ny-zxbm-fuhao">★</span>本表作为劳动合同附件留存 </p></td>
              </tr>
            </table>
<script>
$(function(){
<%
contentID=request("ID")
rs.open "select * from zp where id="&contentID,conn,1,1
if not rs.eof then

'response.write "ok"
 for i = 1 to rs.fields.Count
		
  response.write "$(""#"&rs.fields(i-1).name&""").val("""&rs.fields(i-1).value&""");"
 next 
 
 if rs("field138")<>"" then
 response.write "$(""#photo"").attr(""src"","""&rs.fields(138).value&""");"
 end if
end if
%>
});
</script>


<!-- #include file="../Inc/Foot.asp" -->