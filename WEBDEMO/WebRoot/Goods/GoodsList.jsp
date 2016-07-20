<!-- 
		这是自定义标签模板，如果用不到哪个标签请删除，不然会报错
 -->
<%@ taglib uri="Mytag" prefix="Layout"%>
<Layout:overwrite name="title">
商品列表
</Layout:overwrite>
<%-- <Layout:overwrite name="Mycss"></Layout:overwrite> --%>

<Layout:overwrite name="MyContent">
<div class="row-fluid">
        <div>
            <div class="span12">
                <ul class="breadcrumb">
                    <li>
                        <i class="icon-home"></i>
                        <a href="Home/index.jsp">首页</a>
                        <i class="icon-angle-right"></i>
                    </li>
                    <li>
                        <a href="javascript:void(0)">商品管理</a><i class="icon-angle-right"></i>
                    </li>

                    <li>
                        <a href="javascript:void(0)">商品列表</a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
    <div class="clearfix"></div>
  <div class="row-fluid">
            <div class="span12">
                <div class="portlet box light-grey" style="border-top: 1px solid #eee;">
                    <div class="portlet-body">
                        <div class="clearfix">
                           
                            <div class="btn-group">
                                <a id="addhref" href="Goodsfunction/Addgood.jsp?active=menupage6_2"type="button" class="btn green">添加商品<i class="icon-edit"></i>
                                </a>
                             
                            </div>                      
                              <div id="Delete" class="btn-group">
                                <a href="Goodsfunction/Deletegood.jsp?active=menupage6_2" type="button" class="btn green">删除商品 <i class="icon-edit"></i>
                                </a>
                            </div>  
                            <div id="Update" class="btn-group">
                                <a href="Goodsfunction/Updategood.jsp?active=menupage6_2" type="button" class="btn green">修改商品 <i class="icon-edit"></i>
                                </a>
                            </div>                            
                            
                        </div>
                        <div class="row-fluid">
                            <div class="span6">
                                <div id="sample_1_length" class="dataTables_length">
                                    <label>
                                        <select size="1" name="sample_1_length" id="pagesize" aria-controls="sample_1" class="m-wrap small">
                                            <option value="5">5</option>
                                            <option value="10" selected="selected">10</option>
                                            <option value="20">20</option>
                                            <option value="-1">All</option>

                                        </select> 条记录每页</label>
                                </div>
                            </div>
                            <div class="span6">
                                <div class="dataTables_filter" id="sample_1_filter">
                                    <label>检索: <input type="text" aria-controls="sample_1" class="m-wrap small" id="search" style="height:30px;" placeholder="商品，种类"></label>
                                </div>
                            </div>
                        </div>
                        <table class="table table-striped table-bordered table-hover">
                        <thead>
                            <tr>
                                <th style="text-align: center">
                                    <input type="checkbox" id="chk_All" class="checkboxes" onclick="CheckAll(this)" />
                                </th>
                                <th>商品名称</th>                              
                                <th>商品种类</th>
                                <th>生产厂家</th>
                                <th>商品描述</th>
                                <th>商品价格</th>
                                <th>特价价格</th>
                                <th>商品总数量</th>
                                <th>商品剩余数量</th>
                                <th>商品上架时间</th>
                                <th>商品图片</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody id="ListBody">
							
                        </tbody>
                    </table>
                    <div class="row-fluid">
                        <div class="span6">
                            <div id="pageInfo" class="dataTables_info">
                            </div>
                        </div>
                        <div class="span6">
                            <div class="dataTables_paginate paging_bootstrap pagination">
                                <ul id="pagePart">
                                </ul>
                            </div>
                        </div>
                    </div>
                    </div>
                </div>
            </div>
        </div>
        
        

</Layout:overwrite>
 <Layout:overwrite name="MyScript">
 <script> 
   var pageSize = 10; //一页显示的记录数
    var pageIndex = 1; //当前页
    var PSize = 10;
    var orderby = "", strSearch = "";
    var count = 0;  //总记录数
    $(document).ready(function () {
     getContactList();
        document.getElementById("pagesize").onchange = function () {
            if (this.value < 0) {
                pageSize = count;
            } else
                pageSize = this.value;
            getContactList();
        }
        document.getElementById("search").onkeyup = function () {
            strSearch = this.value;
            getContactList();
        }
    })


 function getContactList() {
        $.ajax({
            url: "Goods/GetGoodByPage",
            type: "POST",
            data: { pageSize: pageSize, pageIndex: pageIndex, strSearch: strSearch},
            dataType: "json",
            success: function (result) {            	
                if (result.code == 1) {
                    count = result.count;
                    var html = "";
                    var data=result.GoodList;          
                    for (var i = 0; i < data.length; i++) {
                        html += '<tr class="odd gradeX">';
                        html += '<td class="sorting_1"><div class="checker"><span><input type="checkbox" onclick="checkItem(this);" class="checkboxes" value=' + data[i].CID + '></span></div></td>';
                        html += '<td class="hidden-480">' + data[i].CNAME+ '</td>';
                        html += '<td class="hidden-480">' + data[i].CCID + '</td>';
                        html += '<td class="hidden-480">' + data[i].CMANUFACTURER + '</td>';
                        html += '<td class="hidden-480">' + data[i].CDEPICT + '</td>';
                        html += '<td class="hidden-480">' + data[i].CPRICE  + '</td>';
                        html += '<td class="hidden-480">' + data[i].CAPRICE + '</td>';
                        html += '<td class="hidden-480">' + data[i].CAMOUNT + '</td>';
                        html += '<td class="hidden-480">' + data[i].CLEAVENUM + '</td>';
                        html += '<td class="hidden-480">' + data[i].CSTARTIME + '</td>';
                       // html += '<td class="hidden-480"><a href="./com.Manager.Communication/EditContact?ID=' + data[i].ID + '&active=menupage6_6" class="label label-important" style="color: white;">编辑</a></td>';
                      
                    }
                    $("#ListBody").html(html);
                }
                else {
                    var html = "";
                    html += "<tr class='odd gradeX'>";
                    html += "<td colspan='10' style='text-align:center'>抱歉，还没有任何信息</td>";
                    html += "</tr>";
                    $("#ListBody").html(html);
                }
                $("#chk_All").attr("checked", false).closest("span").removeClass("checked");

                GetPageInfo(count);
            },
            error: function () {
                console.log("error");
            }
        });
    }

    

    function GetPageInfo(count) {
        var pageHtml = "";
        if (count != 0) {
            recordCount = count;
            pageCount = Math.ceil(recordCount / pageSize);

            if (pageIndex == 1) {
                pageHtml += "<li class='prev disabled' ><a>← <span class='hidden-480'>上一页</span></a></li>";
            }
            else {
                pageHtml += "<li class='prev' onclick='GotoPage(" + Number(pageIndex - 1) + ")'><a>← <span class='hidden-480'>上一页</span></a></li>";
            }

            var PNumCount = Math.ceil(pageCount / PSize);//判断总分页
            var PNum = parseInt((pageIndex - 1) / PSize);//判断第几页分页
            if (PNum >= 1)
                pageHtml += "<li onclick='GotoPage(" + Number((PNum - 1) * PSize + 1) + ")'><a >...</a></li>";
            for (var j = PNum * PSize; j < (pageCount <= PSize * (PNum + 1) ? pageCount : PSize * (PNum + 1)) ; j++) {
                if (j == pageIndex - 1) {
                    pageHtml += "<li class=\"active\"><a >" + (j + 1) + "</a></li>";
                }
                else {
                    pageHtml += "<li onclick='GotoPage(" + (j + 1) + ")'><a >" + (j + 1) + "</a></li>";
                }
            }
            if ((PNum + 1) < PNumCount)
                pageHtml += "<li onclick='GotoPage(" + Number((PNum + 1) * PSize + 1) + ")'><a >...</a></li>";

            if (pageIndex == pageCount) {
                pageHtml += " <li class='next disabled'><a><span class='hidden-480'>下一页</span> → </a></li>";
            }
            else {
                pageHtml += " <li class='next' onclick='GotoPage(" + Number(pageIndex + 1) + ")'><a><span class='hidden-480'>下一页</span> → </a></li>";
            }
            $("#pagePart").html(pageHtml);
            if (pageSize * pageIndex > recordCount) {
                if (recordCount == 0) {
                    $("#pageInfo").html("显示第 0 条数据到 0 条数据，总共 0 页");
                }
                else {
                    $("#pageInfo").html("显示第 " + ((pageIndex - 1) * pageSize + 1) + " 条数据到 " + recordCount + " 条数据，总共 " + pageCount + " 页");
                }
            }
            else {
                $("#pageInfo").html("显示第 " + ((pageIndex - 1) * pageSize + 1) + " 条数据到 " + pageSize * pageIndex + " 条数据，总共 " + pageCount + " 页");
            }
        }
        else {
            pageHtml += "<li class='prev disabled' ><a>← <span class='hidden-480'>上一页</span></a></li>";
            pageHtml += " <li class='next disabled'><a><span class='hidden-480'>下一页</span> → </a></li>";
            $("#pageInfo").html("显示 0 条数据到 0 条数据，总共 0 页");
        }
        $("#pagePart").html(pageHtml);
        if (pageIndex > pageCount) {
            pageIndex = pageCount;
        }
    }

    function GotoPage(topage) {
        pageIndex = topage;
        if (0 < topage && topage <= pageCount)
            getContactList();
    }
   
   </script>  
 </Layout:overwrite> 
<%@ include file="/share/_Layout.jsp"%>